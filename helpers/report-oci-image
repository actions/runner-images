#!/usr/bin/env python3
"""Inspect an OCI image layout without reconstructing its archives or VM disk."""

import argparse
from contextlib import contextmanager
import json
from pathlib import Path
import subprocess
import tarfile
import tempfile
import time
from urllib.parse import quote


class LayerReader:
    """Read consecutive blobs as a single bounded stream."""
    def __init__(self, paths):
        self.paths = iter(paths)
        self.source = None

    def read(self, size):
        if not 0 <= size <= 8 * 1024 ** 2:
            raise ValueError('Layer reads must use bounded buffers.')
        while size:
            if self.source is None:
                path = next(self.paths, None)
                if path is None:
                    return b''
                self.source = path.open('rb')
            data = self.source.read(size)
            if data:
                return data
            self.source.close()
            self.source = None
        return b''

    def close(self):
        if self.source is not None:
            self.source.close()


@contextmanager
def disk_view(paths):
    # nbdkit's split plugin exposes a read-only concatenation, without disk copies.
    with tempfile.TemporaryDirectory(prefix='image-inspect-') as temporary:
        socket = Path(temporary) / 'disk.sock'
        with subprocess.Popen(['nbdkit', '--foreground', '--readonly', '--exit-with-parent',
                               '--unix', str(socket), 'split', *['file=' + str(path) for path in paths]]) as process:
            try:
                deadline = time.monotonic() + 30
                while not socket.exists():
                    if process.poll() is not None:
                        raise RuntimeError(f'nbdkit exited with status {process.returncode}')
                    if time.monotonic() >= deadline:
                        raise TimeoutError('Timed out starting the disk inspection view.')
                    time.sleep(0.1)
                yield str(socket)
            finally:
                process.terminate()
                try:
                    process.wait(timeout=10)
                except subprocess.TimeoutExpired:
                    process.kill()
                    process.wait()


def report(layout_directory):
    directory = Path(layout_directory).resolve()
    blobs = directory / 'blobs' / 'sha256'

    def path(blob):
        return blobs / blob['digest'].split(':')[1]

    index = json.loads((directory / 'index.json').read_bytes())
    entry = index['manifests'][0]
    manifest = json.loads(path(entry).read_bytes())
    config = json.loads(path(manifest['config']).read_bytes())
    title = manifest.get('annotations', {}).get('org.opencontainers.image.title',
                entry.get('annotations', {}).get('org.opencontainers.image.ref.name', 'image'))
    lines = [f'### Image details: {title}', '',
             '| Payload | Format | Compression | Logical bytes | Allocated bytes | Chunks |',
             '| --- | --- | --- | ---: | ---: | ---: |']
    for file in config.get('files', []):
        paths = [path(manifest['layers'][i]) for i in file['layers']]
        allocated = sum(p.stat().st_blocks * 512 for p in paths)
        lines.append(f'| {file["name"]} | {file["format"]} | {file["compression"]} | '
                     f'{file["size"]} | {allocated} | {len(paths)} |')
    lines.extend(['', 'Allocated bytes include sparse-file savings; repeated chunks may share storage.', ''])

    def section(title, content):
        lines.extend([f'#### {title}', '', '````text', content.rstrip(), '````', ''])

    def inspect(title, arguments):
        try:
            result = subprocess.run(arguments, text=True, stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, timeout=180, check=True)
            section(title, result.stdout)
        except (subprocess.SubprocessError, OSError) as error:
            section(title, f'Inspection failed: {error}\n{getattr(error, "output", "") or ""}')

    inspect('Filesystem capacity', ['df', '--block-size=1',
            '--output=source,fstype,size,used,avail,pcent,target', '--', '/', str(directory)])
    if 'files' not in config:
        section('Runtime configuration', json.dumps(config.get('config', {}), indent=2))
        section('Platform', f'{config["os"]}/{config["architecture"]}')
    for file in config.get('files', []):
        paths = [path(manifest['layers'][i]) for i in file['layers']]
        if file['role'] in ('metadata', 'unified') and file['format'] == 'tar':
            source = LayerReader(paths)
            try:
                entries = []
                with tarfile.open(fileobj=source, mode='r|*') as archive:
                    for member in archive:
                        name = member.name.removeprefix('./')
                        if file['role'] == 'unified' and (name == 'rootfs' or name.startswith('rootfs/')):
                            break
                        entries.append(f'{member.name} ({member.size} bytes)')
                        if name == 'metadata.yaml' and member.isfile():
                            with archive.extractfile(member) as metadata:
                                data = metadata.read(1024 ** 2 + 1)
                                if len(data) > 1024 ** 2:
                                    raise ValueError('metadata.yaml exceeds the 1 MiB inspection limit.')
                                section('metadata.yaml', data.decode('utf-8', errors='replace'))
                section(f'Metadata archive: {file["name"]}', '\n'.join(entries))
            except (tarfile.TarError, ValueError, OSError) as error:
                section(f'Metadata inspection: {file["name"]}', str(error))
            finally:
                source.close()
        if file['role'] == 'disk':
            try:
                with disk_view(paths) as socket:
                    inspect('Disk information', ['qemu-img', 'info', '--output=json', '-f', 'qcow2',
                                                'nbd+unix:///?socket=' + quote(socket, safe='/')])
                    inspect('Partition table and filesystems', [
                        'sudo', 'env', 'LIBGUESTFS_BACKEND=direct', 'guestfish', '--ro', '--format=qcow2',
                        '-a', 'nbd:///?socket=' + quote(socket, safe='/'), 'run', ':', 'echo',
                        'Partition table type:', ':', 'part-get-parttype', '/dev/sda', ':',
                        'part-list', '/dev/sda', ':', 'echo', 'Filesystems:', ':', 'list-filesystems',
                    ])
            except (subprocess.SubprocessError, OSError, RuntimeError, TimeoutError) as error:
                section('VM disk inspection', f'Inspection failed: {error}')
    print('\n'.join(lines))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--layout-directory', required=True)
    report(parser.parse_args().layout_directory)
