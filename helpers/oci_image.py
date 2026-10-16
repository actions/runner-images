"""Streaming OCI conversion shared by the standalone image-to-OCI commands.

Python 3.10+; container layers are ordinary tar changesets, VM layers are
ordered byte chunks. No project metadata or CI environment is required.
"""

import argparse
import base64
import bz2
import copy
from contextlib import closing, contextmanager
from email.message import Message
import gzip
import hashlib
import http.client
import json
import lzma
import os
from pathlib import Path, PurePosixPath
import re
import socket
import sys
import subprocess
import tarfile
import tempfile
from urllib.parse import quote, urlencode

PREFIX = 'application/vnd.lxd.image'
MANIFEST = 'application/vnd.oci.image.manifest.v1+json'
INDEX = 'application/vnd.oci.image.index.v1+json'
CONFIG = 'application/vnd.oci.image.config.v1+json'
LAYER = 'application/vnd.oci.image.layer.v1.tar'
CHUNK_SIZE = 1024 ** 3
BUFFER_SIZE = 8 * 1024 ** 2
METADATA_LIMIT = 8 * 1024 ** 2
METADATA_LABEL = 'org.linuxcontainers.image.metadata'


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def descriptor(data, media_type):
    return {'mediaType': media_type, 'digest': 'sha256:' + hashlib.sha256(data).hexdigest(), 'size': len(data)}


def archive_format(path):
    with path.open('rb') as source:
        return stream_format(source.read(512))

class Package:
    def __init__(self, directory, chunk_size):
        self.blobs = directory / 'blobs' / 'sha256'
        self.blobs.mkdir(parents=True)
        self.chunk_size = chunk_size
        self.layers = []
        self.files = []

    def store_json(self, value, media_type):
        data = encoded(value)
        if len(data) > 16 * 1024 ** 2:
            raise ValueError('OCI JSON metadata exceeds 16 MiB.')
        result = descriptor(data, media_type)
        (self.blobs / result['digest'].split(':')[1]).write_bytes(data)
        return result

    def add_file(self, source, name, size, role, file_format, compression, prefix=b''):
        """Stream bounded chunks, hashing the original bytes and retaining holes."""
        checksum = hashlib.sha256()
        layer_indices = []
        remaining = size
        total_size = 0
        while remaining is None or remaining:
            chunk_hash = hashlib.sha256()
            limit = self.chunk_size if remaining is None else min(remaining, self.chunk_size)
            with tempfile.NamedTemporaryFile(dir=self.blobs, delete=False) as chunk:
                temporary = Path(chunk.name)
                chunk_size = 0
                while chunk_size < limit:
                    count = min(BUFFER_SIZE, limit - chunk_size)
                    data = prefix[:count] if prefix else source.read(count)
                    prefix = prefix[len(data):]
                    if not data:
                        if remaining is not None:
                            raise ValueError(f'Unexpected end of exported file: {name}')
                        break
                    checksum.update(data)
                    chunk_hash.update(data)
                    for offset in range(0, len(data), 65536):
                        block = data[offset:offset + 65536]
                        if block.count(0) == len(block):
                            chunk.seek(len(block), os.SEEK_CUR)
                        else:
                            chunk.write(block)
                    chunk_size += len(data)
                chunk.truncate(chunk_size)
            if not chunk_size:
                temporary.unlink()
                break
            digest = chunk_hash.hexdigest()
            destination = self.blobs / digest
            if destination.exists():
                temporary.unlink()
            else:
                temporary.rename(destination)
            media_type = f'{PREFIX}.{role}.{file_format}.chunk.v1'
            if compression != 'none':
                media_type += '+' + compression
            layer_indices.append(len(self.layers))
            self.layers.append({
                'mediaType': media_type, 'digest': 'sha256:' + digest, 'size': chunk_size,
                'annotations': {'org.opencontainers.image.title': f'{name}.part{len(layer_indices) - 1:05d}'},
            })
            total_size += chunk_size
            if remaining is not None:
                remaining -= chunk_size
            print(f'{name}: {total_size} bytes exported into {len(layer_indices)} chunks', file=sys.stderr, flush=True)
            if chunk_size < limit:
                break
        if not layer_indices:
            raise ValueError(f'Exported file is empty: {name}')
        self.files.append({
            'name': name, 'role': role, 'format': file_format, 'compression': compression,
            'size': total_size, 'digest': 'sha256:' + checksum.hexdigest(), 'layers': layer_indices,
        })

    def add_path(self, path, role):
        file_format, compression = archive_format(path)
        with path.open('rb') as source:
            self.add_file(source, path.name, path.stat().st_size, role, file_format, compression)

    def add_unified_vm(self, path, workspace):
        """Separate a unified VM tar stream without assembling another qcow2."""
        metadata_path = workspace / 'metadata.tar'
        disk_found = False
        metadata_found = False
        with tarfile.open(name=path if isinstance(path, (str, Path)) else None,
                          fileobj=None if isinstance(path, (str, Path)) else path,
                          mode='r|*') as archive, tarfile.open(metadata_path, mode='w') as metadata:
            for member in archive:
                name = member.name.removeprefix('./')
                if name == 'rootfs.img':
                    if disk_found or not member.isfile():
                        raise ValueError('Unified VM archive must contain one regular rootfs.img.')
                    with archive.extractfile(member) as disk:
                        prefix = disk.read(4)
                        if prefix != b'QFI\xfb':
                            raise ValueError('Unified VM disk is not qcow2.')
                        self.add_file(disk, 'rootfs.qcow2', member.size, 'disk', 'qcow2', 'none', prefix)
                    disk_found = True
                else:
                    if name == 'metadata.yaml' and member.isfile():
                        metadata_found = True
                    contents = archive.extractfile(member) if member.isfile() else None
                    metadata.addfile(member, contents)
                    if contents is not None:
                        contents.close()
        if not disk_found or not metadata_found:
            raise ValueError('Unified VM archive needs metadata.yaml and rootfs.img.')
        self.add_path(metadata_path, 'metadata')


class PrefixReader:
    def __init__(self, source, prefix=b'', checksum=None):
        self.source = source
        self.prefix = prefix
        self.checksum = checksum

    def read(self, size):
        if not 0 <= size <= BUFFER_SIZE:
            raise ValueError('Image streams must be read with bounded buffers.')
        if self.prefix:
            data, self.prefix = self.prefix[:size], self.prefix[size:]
        else:
            data = self.source.read(size)
        if self.checksum is not None:
            self.checksum.update(data)
        return data


class Multipart:
    """Read LXD's multipart response without buffering an entire part."""
    def __init__(self, source, boundary):
        if not boundary or len(boundary) > 200 or '\r' in boundary or '\n' in boundary:
            raise ValueError('Invalid multipart export boundary.')
        self.source = source
        self.boundary = b'--' + boundary.encode('ascii')
        self.buffer = b''

    def fill(self):
        data = self.source.read(BUFFER_SIZE)
        if not data:
            raise ValueError('Truncated multipart image export.')
        self.buffer += data

    def line(self):
        while b'\r\n' not in self.buffer:
            if len(self.buffer) > 16384:
                raise ValueError('Multipart image header exceeds 16 KiB.')
            self.fill()
        line, self.buffer = self.buffer.split(b'\r\n', 1)
        if len(line) > 16384:
            raise ValueError('Multipart image header exceeds 16 KiB.')
        return line

    def parts(self):
        delimiter = self.line()
        while delimiter != self.boundary + b'--':
            if delimiter != self.boundary:
                raise ValueError('Invalid multipart image delimiter.')
            headers = Message()
            length = 0
            while line := self.line():
                length += len(line)
                if length > 16384 or b':' not in line:
                    raise ValueError('Invalid multipart image headers.')
                key, value = line.decode('utf-8').split(':', 1)
                headers[key] = value.strip()
            part = MultipartPart(self)
            yield headers, part
            if part.read(1):
                raise ValueError('Multipart image part was not fully consumed.')
            delimiter = self.line()


class MultipartPart:
    def __init__(self, parent):
        self.parent = parent
        self.finished = False

    def read(self, size):
        if not 0 <= size <= BUFFER_SIZE:
            raise ValueError('Multipart reads must use bounded buffers.')
        result = bytearray()
        marker = b'\r\n' + self.parent.boundary
        while len(result) < size and not self.finished:
            position = self.parent.buffer.find(marker)
            if position >= 0:
                end = position + len(marker)
                while len(self.parent.buffer) < end + 2:
                    self.parent.fill()
                if self.parent.buffer[end:end + 2] not in (b'\r\n', b'--'):
                    # A boundary-like byte sequence inside the payload is data.
                    available = position + 2
                else:
                    available = position
                    if not available:
                        self.parent.buffer = self.parent.buffer[2:]
                        self.finished = True
                        break
            else:
                available = max(0, len(self.parent.buffer) - len(marker) - 1)
            if not available:
                self.parent.fill()
                continue
            count = min(size - len(result), available)
            result.extend(self.parent.buffer[:count])
            self.parent.buffer = self.parent.buffer[count:]
        return bytes(result)


class LXDConnection(http.client.HTTPConnection):
    def __init__(self, socket_path):
        super().__init__('localhost', timeout=300)
        self.socket_path = str(socket_path)

    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.settimeout(self.timeout)
        self.sock.connect(self.socket_path)


def stream_format(prefix):
    for signature, compression in [(b'\xfd7zXZ\x00', 'xz'), (b'\x1f\x8b', 'gzip'),
                                   (b'BZh', 'bzip2'), (b'\x28\xb5\x2f\xfd', 'zstd')]:
        if prefix.startswith(signature):
            return 'tar', compression
    if prefix.startswith(b'QFI\xfb'):
        return 'qcow2', 'none'
    if prefix.startswith(b'hsqs'):
        return 'squashfs', 'none'
    try:
        tarfile.TarInfo.frombuf(prefix, 'utf-8', 'surrogateescape')
    except tarfile.HeaderError as error:
        raise ValueError('Unsupported LXD export stream format.') from error
    return 'tar', 'none'



class Layout:
    def __init__(self, directory, reference='image', annotations=None):
        self.directory = Path(directory).resolve()
        self.reference = reference
        self.annotations = annotations or {}

    def __enter__(self):
        if self.directory.exists():
            raise FileExistsError(f'OCI output directory already exists: {self.directory}')
        self.directory.parent.mkdir(parents=True, exist_ok=True)
        self.temporary = tempfile.TemporaryDirectory(prefix='.image-oci-', dir=self.directory.parent)
        self.workspace = Path(self.temporary.name)
        self.path = self.workspace / 'layout'
        self.package = Package(self.path, CHUNK_SIZE)
        return self

    def finish(self, config, layers, artifact_type=None):
        config = self.package.store_json(config, f'{PREFIX}.vm.config.v1+json' if artifact_type else CONFIG)
        manifest = {'schemaVersion': 2, 'mediaType': MANIFEST, 'config': config, 'layers': layers}
        if artifact_type:
            manifest['artifactType'] = artifact_type
        if self.annotations:
            manifest['annotations'] = self.annotations
        entry = self.package.store_json(manifest, MANIFEST)
        entry['annotations'] = {'org.opencontainers.image.ref.name': self.reference}
        (self.path / 'index.json').write_bytes(encoded({'schemaVersion': 2, 'mediaType': INDEX, 'manifests': [entry]}))
        (self.path / 'oci-layout').write_bytes(encoded({'imageLayoutVersion': '1.0.0'}))
        self.path.rename(self.directory)
        self.package.blobs = self.directory / 'blobs' / 'sha256'
        return self.directory

    def __exit__(self, *exception):
        self.temporary.cleanup()


class LayerWriter:
    """Pack complete entries and hardlink groups into independently usable tar layers."""
    def __init__(self, layout, limit):
        if limit < tarfile.RECORDSIZE:
            raise ValueError(f'Layer size must be at least {tarfile.RECORDSIZE} bytes.')
        self.layout = layout
        self.limit = limit
        self.layers = []
        self.writer = None
        self.names = set()
        self.groups = {}

    @staticmethod
    def final_size(size):
        return ((size + 1024 + tarfile.RECORDSIZE - 1) // tarfile.RECORDSIZE) * tarfile.RECORDSIZE

    @staticmethod
    def clean(member):
        member = copy.copy(member)
        member.pax_headers = {key: value for key, value in member.pax_headers.items()
                              if not key.startswith('GNU.sparse.')}
        if member.sparse is not None:
            member.type = tarfile.REGTYPE
        member.sparse = None
        return member

    @staticmethod
    def entry_size(member):
        return len(member.tobuf(format=tarfile.PAX_FORMAT)) + ((member.size + 511) // 512) * 512

    def add(self, member, source=None):
        member = self.clean(member)
        if not member.islnk():
            location, offset = self._add(member, source)
            if not member.isdir():
                self.groups[member.name] = {'member': member, 'location': location, 'offset': offset,
                                            'links': []}
            return
        group = self.groups.get(member.linkname)
        if group is None:
            raise ValueError(f'Hardlink target must precede its link in the source tar: {member.linkname!r}')
        canonical = group['member']
        member.linkname = canonical.name
        members = [canonical, *group['links'], member]
        total = sum(self.entry_size(entry) for entry in members)
        if self.final_size(total) > self.limit:
            raise ValueError(f'Hardlink group for {canonical.name!r} cannot fit in --layer-size={self.limit}.')
        present = self.writer is not None and all(entry.name in self.names for entry in members[:-1])
        if present and self.final_size(self.writer.offset + self.entry_size(member)) <= self.limit:
            self._add(member)
        else:
            # Docker cannot reliably link to an entry in a lower layer. Re-emit
            # the whole known group in this layer, keeping all names one inode.
            self.close()
            location, offset = group['location'], group['offset']
            if canonical.isfile():
                with Path(location['path']).open('rb') as body:
                    body.seek(offset)
                    new_location, new_offset = self._add(canonical, body)
            else:
                new_location, new_offset = self._add(canonical)
            group['location'], group['offset'] = new_location, new_offset
            for link in members[1:]:
                self._add(link)
        group['links'].append(member)
        self.groups[member.name] = group

    def _add(self, member, source=None):
        size = self.entry_size(member)
        if self.final_size(size) > self.limit:
            raise ValueError(f'Tar entry {member.name!r} cannot fit in a {self.limit}-byte layer; '
                             'increase --layer-size. A file cannot be byte-split in a runnable OCI image.')
        if self.writer and (member.name in self.names or self.final_size(self.writer.offset + size) > self.limit):
            self.close()
        if self.writer is None:
            self.file = tempfile.NamedTemporaryFile(dir=self.layout.package.blobs, delete=False)
            self.location = {'path': self.file.name}
            self.writer = tarfile.open(fileobj=self.file, mode='w', format=tarfile.PAX_FORMAT)
            self.names = set()
        offset = self.writer.offset + len(member.tobuf(format=tarfile.PAX_FORMAT))
        self.writer.addfile(member, source)
        self.names.add(member.name)
        return self.location, offset

    def close(self):
        if self.writer is None:
            return
        try:
            self.writer.close()
        finally:
            self.writer = None
            self.file.close()
        path = Path(self.file.name)
        checksum = hashlib.sha256()
        with path.open('rb') as source:
            while data := source.read(BUFFER_SIZE):
                checksum.update(data)
        digest = 'sha256:' + checksum.hexdigest()
        target = self.layout.package.blobs / checksum.hexdigest()
        if target.exists():
            path.unlink()
        else:
            path.rename(target)
        self.location['path'] = target
        self.layers.append({'mediaType': LAYER, 'digest': digest, 'size': target.stat().st_size})

    def abort(self):
        if self.writer is not None:
            self.file.close()
            self.writer = None


def safe_name(name):
    if name.startswith('/') or '..' in PurePosixPath(name).parts or '\0' in name:
        raise ValueError(f'Unsafe tar path: {name!r}')
    return str(PurePosixPath(name))


@contextmanager
def decompressed(source):
    prefix = bytearray()
    while len(prefix) < 6:
        data = source.read(6 - len(prefix))
        if not data:
            break
        prefix.extend(data)
    reader = PrefixReader(source, bytes(prefix))
    if prefix.startswith(b'\x1f\x8b'):
        stream = gzip.GzipFile(fileobj=reader)
    elif prefix.startswith(b'\xfd7zXZ\x00'):
        stream = lzma.LZMAFile(reader)
    elif prefix.startswith(b'BZh'):
        stream = bz2.BZ2File(reader)
    elif prefix.startswith(b'\x28\xb5\x2f\xfd'):
        try:
            from compression import zstd
        except ImportError as error:
            raise ValueError('Zstd tar input requires Python 3.14 or later.') from error
        stream = zstd.ZstdFile(reader)
    else:
        stream = reader
    try:
        yield stream
    finally:
        if stream is not reader:
            stream.close()


def tar_layers(source, layout, limit, rootfs_prefix=None, docker=False, metadata=None):
    """Move whiteouts ahead of split changesets, retaining their original scope."""
    writer = LayerWriter(layout, limit)
    whiteouts = LayerWriter(layout, limit)
    checksum = hashlib.sha256()
    rootfs_found = False
    try:
        with decompressed(source) as stream:
            reader = PrefixReader(stream, checksum=checksum)
            with tarfile.open(fileobj=reader, mode='r|') as archive:
                for member in archive:
                    member = copy.copy(member)
                    name = safe_name(member.name)
                    if rootfs_prefix is not None:
                        if name == rootfs_prefix:
                            name = '.'
                        elif name.startswith(rootfs_prefix + '/'):
                            name = name[len(rootfs_prefix) + 1:]
                        else:
                            if metadata is not None:
                                if metadata.offset + member.size + len(member.tobuf(format=tarfile.PAX_FORMAT)) > METADATA_LIMIT - 10240:
                                    raise ValueError('LXD metadata exceeds the 8 MiB config-label limit.')
                                contents = archive.extractfile(member) if member.isfile() else None
                                try:
                                    metadata.addfile(member, contents)
                                finally:
                                    if contents is not None:
                                        contents.close()
                            continue
                        rootfs_found = True
                    member.name = name
                    # PAX path/linkpath override TarInfo when reserialized.
                    member.pax_headers = dict(member.pax_headers)
                    member.pax_headers.pop('path', None)
                    member.pax_headers.pop('linkpath', None)
                    if member.islnk():
                        link = safe_name(member.linkname)
                        if rootfs_prefix is not None:
                            if not link.startswith(rootfs_prefix + '/'):
                                raise ValueError('Hardlink target is outside the root filesystem.')
                            link = link[len(rootfs_prefix) + 1:]
                        member.linkname = link
                    if PurePosixPath(name).name.startswith('.wh.'):
                        if not docker or not member.isfile() or member.size:
                            raise ValueError(f'Unsupported whiteout entry: {name}')
                        whiteouts.add(member)
                        continue
                    contents = archive.extractfile(member) if member.isfile() else None
                    try:
                        writer.add(member, contents)
                    finally:
                        if contents is not None:
                            contents.close()
            # Include trailing tar records in the original diffID and LXD fingerprint.
            while reader.read(BUFFER_SIZE):
                pass
        writer.close()
        whiteouts.close()
    except BaseException:
        writer.abort()
        whiteouts.abort()
        raise

    if rootfs_prefix is not None and not rootfs_found:
        raise ValueError('Unified container archive has no rootfs directory.')
    return whiteouts.layers + writer.layers, 'sha256:' + checksum.hexdigest()


def container_config(architecture, layers, runtime=None, os_name='linux'):
    return {'architecture': architecture, 'os': os_name,
            'config': runtime if runtime is not None else {'Cmd': ['/bin/sh']},
            'rootfs': {'type': 'layers', 'diff_ids': [layer['digest'] for layer in layers]},
            'history': [{'created_by': 'image-to-oci'} for _ in layers]}


def vm_config(package, architecture, os_name, chunk_size):
    return {'schemaVersion': 1, 'architecture': architecture, 'os': os_name,
            'chunkSize': chunk_size, 'files': package.files}


@contextmanager
def command_stream(arguments):
    """Reap a producer on success, parser failure, or interrupt; stderr is inherited."""
    process = subprocess.Popen(arguments, stdout=subprocess.PIPE)
    try:
        yield process.stdout
        if process.wait() != 0:
            raise RuntimeError(f'{arguments[0]} exited with status {process.returncode}')
    finally:
        process.stdout.close()
        if process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=10)
            except subprocess.TimeoutExpired:
                process.kill()
                process.wait()


def container_payload(source, layout, limit, runtime, architecture, unified=False):
    prefix = bytearray()
    while len(prefix) < 4:
        data = source.read(4 - len(prefix))
        if not data:
            break
        prefix.extend(data)
    reader = PrefixReader(source, bytes(prefix))
    if prefix == b'hsqs':
        # SquashFS uses random access; only its compressed input is staged.
        # CI's uncompressed unified tar exports do not take this fallback.
        path = layout.workspace / 'rootfs.squashfs'
        with path.open('wb') as target:
            while data := reader.read(BUFFER_SIZE):
                target.write(data)
        with command_stream(['sqfs2tar', '--no-skip', '--root-becomes', '.', str(path)]) as tar:
            layers, _ = tar_layers(tar, layout, limit)
        path.unlink()
    else:
        if unified:
            metadata_path = layout.workspace / 'metadata.tar'
            with tarfile.open(metadata_path, mode='w', format=tarfile.PAX_FORMAT) as metadata:
                layers, _ = tar_layers(reader, layout, limit, rootfs_prefix='rootfs', metadata=metadata)
            config = container_config(architecture, layers, runtime)
            retain_metadata(config, metadata_path.read_bytes())
            metadata_path.unlink()
            return config, layers
        layers, _ = tar_layers(reader, layout, limit)
    return container_config(architecture, layers, runtime), layers


def retain_metadata(config, metadata):
    if len(metadata) > METADATA_LIMIT:
        raise ValueError('LXD metadata exceeds the 8 MiB config-label limit.')
    runtime = copy.deepcopy(config['config'])
    runtime['Labels'] = dict(runtime.get('Labels') or {})
    runtime['Labels'][METADATA_LABEL] = base64.b64encode(metadata).decode('ascii')
    config['config'] = runtime


def lxd_response(response, layout, architecture, vm=False, limit=CHUNK_SIZE, runtime=None,
                 fingerprint=None, os_name='linux'):
    checksum = hashlib.sha256()
    multipart = response.headers.get_content_type() == 'multipart/form-data'
    parts = (Multipart(response, response.headers.get_param('boundary')).parts() if multipart
             else [(response.headers, response)])
    roles = []
    container = None
    metadata = None
    package = layout.package
    package.chunk_size = limit
    for headers, part in parts:
        name = headers.get_filename()
        if not name or name in ('.', '..') or any(c in name for c in '/\\\0\r\n'):
            raise ValueError('Missing or unsafe LXD export filename.')
        form = headers.get_param('name', header='content-disposition')
        if multipart and form not in ('metadata', 'rootfs', 'rootfs.img'):
            raise ValueError('Unsupported multipart LXD image part.')
        role = ('metadata' if form == 'metadata' else 'disk' if vm else 'rootfs') if multipart else 'unified'
        if role in roles:
            raise ValueError('Duplicate multipart LXD payload.')
        roles.append(role)
        reader = PrefixReader(part, checksum=checksum)
        if not vm and role != 'metadata':
            container = container_payload(reader, layout, limit, runtime, architecture, unified=not multipart)
        elif not vm:
            metadata = bytearray()
            while data := reader.read(min(BUFFER_SIZE, METADATA_LIMIT + 1 - len(metadata))):
                metadata.extend(data)
                if len(metadata) > METADATA_LIMIT:
                    raise ValueError('LXD metadata exceeds the 8 MiB config-label limit.')
        elif not multipart:
            package.add_unified_vm(reader, layout.workspace)
        else:
            prefix = bytearray()
            while len(prefix) < 512:
                data = reader.read(512 - len(prefix))
                if not data:
                    break
                prefix.extend(data)
            file_format, compression = stream_format(prefix)
            if role == 'metadata' and file_format != 'tar':
                raise ValueError('LXD metadata must be a tar archive.')
            if role == 'disk' and file_format != 'qcow2':
                raise ValueError('VM payload must be a complete qcow2 disk.')
            package.add_file(reader, name, None, role, file_format, compression, bytes(prefix))
        while reader.read(BUFFER_SIZE):
            pass
    if multipart and sorted(roles) != (['disk', 'metadata'] if vm else ['metadata', 'rootfs']):
        raise ValueError('LXD export needs metadata and a payload.')
    if fingerprint and checksum.hexdigest() != fingerprint:
        raise ValueError('LXD export fingerprint does not match the streamed bytes.')
    if vm:
        return vm_config(package, architecture, os_name, limit), package.layers
    if container is None:
        raise ValueError('Container root filesystem is missing.')
    if metadata is not None:
        retain_metadata(container[0], metadata)
    return container


@contextmanager
def lxd_export(image, socket_path=None, project='default', vm=False):
    if socket_path is None:
        socket_path = os.environ.get('LXD_SOCKET')
    if not socket_path and os.environ.get('LXD_DIR'):
        socket_path = Path(os.environ['LXD_DIR']) / 'unix.socket'
    if not socket_path:
        socket_path = next((path for path in (Path('/var/snap/lxd/common/lxd/unix.socket'),
                                              Path('/var/lib/lxd/unix.socket')) if path.exists()), None)
    if not socket_path:
        raise ValueError('No local LXD socket found; pass --socket explicitly.')
    query = urlencode({'project': project, 'type': 'virtual-machine' if vm else 'container'})
    with closing(LXDConnection(socket_path)) as connection:
        if re.fullmatch(r'[0-9a-f]{64}', image):
            fingerprint = image
        else:
            connection.request('GET', '/1.0/images/aliases/' + quote(image, safe='') + '?' + query)
            with connection.getresponse() as response:
                if response.status != 200:
                    raise ValueError(f'LXD alias lookup failed: HTTP {response.status}')
                data = response.read(1024 ** 2 + 1)
                if len(data) > 1024 ** 2:
                    raise ValueError('LXD alias response exceeds 1 MiB.')
                fingerprint = json.loads(data)['metadata']['target']
        if not re.fullmatch(r'[0-9a-f]{64}', fingerprint):
            raise ValueError('LXD alias does not identify a complete image fingerprint.')
        connection.request('GET', '/1.0/images/' + fingerprint + '/export?' + query)
        with connection.getresponse() as response:
            if response.status != 200:
                raise ValueError(f'LXD image export failed: HTTP {response.status}')
            yield response, fingerprint


def from_exports(directory, layout, architecture, vm, limit, runtime=None, os_name='linux'):
    source = Path(directory).resolve(strict=True)
    if source == layout.directory or source in layout.directory.parents or layout.directory in source.parents:
        raise ValueError('Export and OCI directories must not contain each other.')
    paths = sorted(source.iterdir())
    if not paths or any(path.is_symlink() or not path.is_file() for path in paths):
        raise ValueError('Export directory must contain only regular exported files.')
    metadata = [path for path in paths if path.name.startswith('meta-')]
    package = layout.package
    package.chunk_size = limit
    if len(paths) == 1 and not metadata:
        with paths[0].open('rb') as stream:
            if vm:
                package.add_unified_vm(stream, layout.workspace)
            else:
                return container_payload(stream, layout, limit, runtime, architecture, unified=True)
    elif len(paths) == 2 and len(metadata) == 1:
        payload = next(path for path in paths if path not in metadata)
        if vm:
            if archive_format(metadata[0])[0] != 'tar' or archive_format(payload) != ('qcow2', 'none'):
                raise ValueError('VM export needs a metadata tar archive and a qcow2 disk.')
            package.add_path(metadata[0], 'metadata')
            package.add_path(payload, 'disk')
        else:
            if metadata[0].stat().st_size > METADATA_LIMIT:
                raise ValueError('LXD metadata exceeds the 8 MiB config-label limit.')
            with payload.open('rb') as stream:
                config, layers = container_payload(stream, layout, limit, runtime, architecture)
            retain_metadata(config, metadata[0].read_bytes())
            return config, layers
    else:
        raise ValueError('Expected one unified archive or split metadata and payload files.')
    return vm_config(package, architecture, os_name, limit), package.layers


def convert_lxd(output_directory, architecture, image=None, export_directory=None, vm=False,
                socket_path=None, project='default', limit=CHUNK_SIZE, runtime=None,
                reference='image', annotations=None, os_name='linux'):
    if not isinstance(architecture, str) or not re.fullmatch(r'[a-z0-9][a-z0-9_-]*', architecture):
        raise ValueError('Expected an OCI architecture name, such as amd64 or arm64.')
    if not isinstance(os_name, str) or not re.fullmatch(r'[a-z0-9][a-z0-9_-]*', os_name):
        raise ValueError('Expected an OCI operating system name.')
    if vm and not 1 <= limit <= CHUNK_SIZE:
        raise ValueError('VM chunk size must be between 1 byte and 1 GiB.')
    with Layout(output_directory, reference, annotations) as layout:
        if image:
            with lxd_export(image, socket_path, project, vm) as (response, fingerprint):
                config, layers = lxd_response(response, layout, architecture, vm, limit, runtime, fingerprint, os_name)
        else:
            config, layers = from_exports(export_directory, layout, architecture, vm, limit, runtime, os_name)
        return layout.finish(config, layers, f'{PREFIX}.vm.v1' if vm else None)


def docker_archive(source, layout, image_id, limit, os_name, platform=None):
    """Stream docker save (legacy or OCI-backed) without a full saved archive."""
    metadata = {}
    converted = {}
    with tarfile.open(fileobj=source, mode='r|') as archive:
        for member in archive:
            if not member.isfile():
                continue
            name = safe_name(member.name)
            with archive.extractfile(member) as raw:
                prefix = raw.read(min(512, member.size))
                contents = PrefixReader(raw, prefix)
                if name.endswith('.json') or (name.startswith('blobs/sha256/') and prefix.lstrip().startswith(b'{')):
                    if member.size > 16 * 1024 ** 2:
                        raise ValueError(f'Image metadata exceeds 16 MiB: {name}')
                    data = bytearray()
                    while chunk := contents.read(min(BUFFER_SIZE, 16 * 1024 ** 2 + 1 - len(data))):
                        data.extend(chunk)
                    metadata[name] = bytes(data)
                elif name.endswith('/layer.tar') or name.startswith('blobs/sha256/'):
                    if os_name == 'windows':
                        # Windows layers carry platform-specific installation state.
                        # Preserve them exactly; splitting them requires Windows validation.
                        if member.size > limit:
                            raise ValueError('Windows layer exceeds --layer-size; splitting Windows layers is unsupported.')
                        path = layout.workspace / 'windows-layer.tar'
                        checksum = hashlib.sha256()
                        with path.open('wb') as target:
                            while data := contents.read(BUFFER_SIZE):
                                target.write(data)
                                checksum.update(data)
                        digest = 'sha256:' + checksum.hexdigest()
                        path.rename(layout.package.blobs / checksum.hexdigest())
                        converted[name] = ([{'mediaType': LAYER, 'digest': digest, 'size': member.size}], digest)
                    else:
                        converted[name] = tar_layers(contents, layout, limit, docker=True)
    # docker save includes a Docker archive manifest even with OCI-backed storage.
    entries = json.loads(metadata.get('manifest.json', b'[]'))
    matches = [entry for entry in entries if entry['Config'] in (f'{image_id}.json', f'blobs/sha256/{image_id}')]
    if not matches and platform:
        # With the containerd image store, Docker's image ID can identify an
        # index/manifest rather than the image config. Match its selected platform.
        matches = [entry for entry in entries
                   if (candidate := json.loads(metadata[entry['Config']])).get('os') == platform['Os']
                   and candidate.get('architecture') == platform['Architecture']
                   and candidate.get('rootfs', {}).get('diff_ids') == platform['RootFS']['Layers']]
    if len(matches) != 1:
        raise ValueError('Docker save did not identify exactly one requested image.')
    entry = matches[0]
    data = metadata[entry['Config']]
    config_id = entry['Config'].removeprefix('blobs/sha256/').removesuffix('.json')
    if hashlib.sha256(data).hexdigest() != config_id:
        raise ValueError('Docker image config digest mismatch.')
    config = json.loads(data)
    original_ids = config['rootfs']['diff_ids']
    if len(original_ids) != len(entry['Layers']):
        raise ValueError('Docker layer and diffID counts do not match.')
    layers = []
    counts = []
    for original_id, name in zip(original_ids, entry['Layers']):
        parts, digest = converted[name]
        if digest != original_id:
            raise ValueError(f'Docker layer diffID mismatch: {name}')
        layers.extend(parts)
        counts.append(len(parts))
    config['rootfs'] = {'type': 'layers', 'diff_ids': [part['digest'] for part in layers]}
    history = config.get('history')
    if history is not None:
        expanded = []
        nonempty = iter(counts)
        for record in history:
            if record.get('empty_layer'):
                expanded.append(record)
                continue
            count = next(nonempty, None)
            if count is None:
                raise ValueError('Docker history has too many filesystem layers.')
            expanded.extend([dict(record) for _ in range(count)])
        if next(nonempty, None) is not None:
            raise ValueError('Docker history has too few filesystem layers.')
        config['history'] = expanded
    # Discard blobs from OCI archive metadata not referenced by the Docker manifest.
    keep = {part['digest'].split(':')[1] for part in layers}
    for path in layout.package.blobs.iterdir():
        if path.name not in keep:
            path.unlink()
    return config, layers


def convert_docker(image, output_directory, limit=CHUNK_SIZE, reference='image', annotations=None):
    result = subprocess.run(['docker', 'image', 'inspect', image], check=True, stdout=subprocess.PIPE)
    inspected = json.loads(result.stdout)
    if len(inspected) != 1 or not re.fullmatch(r'sha256:[0-9a-f]{64}', inspected[0]['Id']):
        raise ValueError('Expected one local Docker image with a full ID.')
    image_id = inspected[0]['Id']
    with Layout(output_directory, reference, annotations) as layout:
        arguments = ['docker', 'image', 'save']
        if inspected[0].get('Descriptor', {}).get('mediaType') in (
                INDEX, 'application/vnd.docker.distribution.manifest.list.v2+json'):
            platform = inspected[0]['Os'] + '/' + inspected[0]['Architecture']
            if inspected[0].get('Variant'):
                platform += '/' + inspected[0]['Variant']
            arguments += ['--platform', platform]
        with command_stream([*arguments, image_id]) as source:
            config, layers = docker_archive(source, layout, image_id.split(':')[1], limit,
                                             inspected[0]['Os'], inspected[0])
        return layout.finish(config, layers)


def common_arguments(parser):
    parser.add_argument('--output-directory', required=True, help='New OCI image layout directory')
    parser.add_argument('--reference', default='image', help='Local OCI reference name (default: image)')
    parser.add_argument('--annotation', action='append', default=[], metavar='KEY=VALUE', help='Manifest annotation')


def annotations(values):
    result = {}
    for value in values:
        key, separator, content = value.partition('=')
        if not separator or not key:
            raise ValueError('Annotations must be KEY=VALUE.')
        result[key] = content
    return result


def lxd_main(vm=False):
    parser = argparse.ArgumentParser(description='Convert a local LXD VM to an OCI artifact.' if vm else
                                     'Convert a local LXD container image to a runnable OCI image.')
    common_arguments(parser)
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument('--image', help='Local LXD image alias or full fingerprint')
    source.add_argument('--export-directory', help='Directory containing unified or split LXD export files')
    parser.add_argument('--architecture', required=True, help='OCI architecture, such as amd64 or arm64')
    parser.add_argument('--socket', help='LXD Unix socket path')
    parser.add_argument('--project', default='default')
    if vm:
        parser.add_argument('--os', default='linux', help='Guest operating system')
        parser.add_argument('--chunk-size', type=int, default=CHUNK_SIZE, help='Maximum payload chunk bytes')
    else:
        parser.add_argument('--layer-size', type=int, default=CHUNK_SIZE, help='Maximum complete tar layer bytes')
        parser.add_argument('--config', type=Path, help='JSON OCI runtime config object (User, Env, Cmd, etc.)')
    args = parser.parse_args()
    runtime = json.loads(args.config.read_bytes()) if not vm and args.config else None
    if runtime is not None and not isinstance(runtime, dict):
        raise ValueError('Runtime config must be a JSON object.')
    result = convert_lxd(args.output_directory, args.architecture, image=args.image,
                         export_directory=args.export_directory, vm=vm, socket_path=args.socket,
                         project=args.project, limit=args.chunk_size if vm else args.layer_size,
                         runtime=runtime, reference=args.reference, annotations=annotations(args.annotation),
                         os_name=args.os if vm else 'linux')
    print(result)


def docker_main():
    parser = argparse.ArgumentParser(description='Convert a local Docker image to a runnable OCI image.')
    common_arguments(parser)
    parser.add_argument('--image', required=True, help='Local Docker image name or ID')
    parser.add_argument('--layer-size', type=int, default=CHUNK_SIZE, help='Maximum complete tar layer bytes')
    args = parser.parse_args()
    print(convert_docker(args.image, args.output_directory, args.layer_size, args.reference, annotations(args.annotation)))
