import base64
import contextlib
from email.message import Message
import gzip
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('oci_image', Path(__file__).parents[1] / 'oci_image.py')
oci = importlib.util.module_from_spec(spec)
spec.loader.exec_module(oci)


def tar(members):
    result = io.BytesIO()
    with tarfile.open(fileobj=result, mode='w', format=tarfile.PAX_FORMAT) as archive:
        for member, data in members:
            if isinstance(member, str):
                info = tarfile.TarInfo(member)
                info.size = len(data)
                member = info
            archive.addfile(member, io.BytesIO(data) if data is not None else None)
    return result.getvalue()


def read_layout(layout):
    def read(descriptor):
        path = layout / 'blobs/sha256' / descriptor['digest'].split(':')[1]
        assert path.is_file() and not path.is_symlink()
        data = path.read_bytes()
        assert len(data) == descriptor['size']
        assert 'sha256:' + hashlib.sha256(data).hexdigest() == descriptor['digest']
        return data
    assert json.loads((layout / 'oci-layout').read_bytes()) == {'imageLayoutVersion': '1.0.0'}
    index = json.loads((layout / 'index.json').read_bytes())
    assert index['schemaVersion'] == 2 and index['mediaType'] == oci.INDEX
    assert len(index['manifests']) == 1
    manifest = json.loads(read(index['manifests'][0]))
    assert manifest['schemaVersion'] == 2 and manifest['mediaType'] == oci.MANIFEST
    config = json.loads(read(manifest['config']))
    layers = [read(part) for part in manifest['layers']]
    if manifest.get('artifactType') == f'{oci.PREFIX}.vm.v1':
        assert manifest['config']['mediaType'] == f'{oci.PREFIX}.vm.config.v1+json'
        assert config['schemaVersion'] == 1
        assert 0 < config['chunkSize'] <= oci.CHUNK_SIZE
        assert sorted(file['role'] for file in config['files']) == ['disk', 'metadata']
        assert len({file['name'] for file in config['files']}) == len(config['files'])
        used = []
        for file in config['files']:
            assert file['name'] not in ('', '.', '..')
            assert not any(character in file['name'] for character in '/\\\0\r\n')
            assert file['format'] == ('qcow2' if file['role'] == 'disk' else 'tar')
            media_type = f'{oci.PREFIX}.{file["role"]}.{file["format"]}.chunk.v1'
            if file['compression'] != 'none':
                media_type += '+' + file['compression']
            assert file['layers']
            for i in file['layers']:
                assert type(i) is int and 0 <= i < len(layers)
                assert manifest['layers'][i]['mediaType'] == media_type
                assert 0 < len(layers[i]) <= config['chunkSize']
            data = b''.join(layers[i] for i in file['layers'])
            assert len(data) == file['size']
            assert 'sha256:' + hashlib.sha256(data).hexdigest() == file['digest']
            used.extend(file['layers'])
        assert sorted(used) == list(range(len(layers)))
    else:
        assert 'artifactType' not in manifest
        assert manifest['config']['mediaType'] == oci.CONFIG
        assert config['rootfs'] == {'type': 'layers', 'diff_ids': [
            'sha256:' + hashlib.sha256(data).hexdigest() for data in layers]}
        assert all(part['mediaType'] == oci.LAYER for part in manifest['layers'])
        if 'history' in config:
            assert sum(not item.get('empty_layer') for item in config['history']) == len(layers)
        for data in layers:
            with tarfile.open(fileobj=io.BytesIO(data)) as archive:
                names = archive.getnames()
                assert len(names) == len(set(names))
                assert all(not name.startswith('/') and '..' not in Path(name).parts for name in names)
    return manifest, config, layers


class Response(io.BytesIO):
    def __init__(self, data, content_type='application/octet-stream', filename='image.tar'):
        super().__init__(data)
        self.headers = Message()
        self.headers['Content-Type'] = content_type
        self.headers['Content-Disposition'] = f'attachment; filename="{filename}"'

    def read(self, size):
        if not 0 <= size <= oci.BUFFER_SIZE:
            raise AssertionError('Unbounded HTTP read')
        return super().read(min(size, 17))


def multipart(parts, complete=True):
    body = b''
    for role, filename, data in parts:
        body += (f'--boundary\r\nContent-Disposition: form-data; name="{role}"; '
                 f'filename="{filename}"\r\n\r\n').encode() + data + b'\r\n'
    if complete:
        body += b'--boundary--\r\n'
    return Response(body, 'multipart/form-data; boundary="boundary"')


class ConversionTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='standalone-oci-test-')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.output = self.root / 'oci'
        self.metadata = tar([('metadata.yaml', b'architecture: x86_64\n'), ('templates/test.tpl', b'template')])

    def response(self, response, original, vm=False, limit=20480, runtime=None, fingerprint=None):
        with oci.Layout(self.output) as layout:
            config, layers = oci.lxd_response(response, layout, 'riscv64', vm, limit, runtime,
                                             fingerprint or hashlib.sha256(original).hexdigest())
            layout.finish(config, layers, f'{oci.PREFIX}.vm.v1' if vm else None)
        return read_layout(self.output)

    def test_unified_container_is_runnable_and_has_no_project_metadata(self):
        file = tarfile.TarInfo('rootfs/owned')
        file.size = 15000
        file.uid, file.gid, file.mode = 1234, 4321, 0o6750
        file.pax_headers = {'SCHILY.xattr.user.test': 'preserved'}
        symlink = tarfile.TarInfo('rootfs/link')
        symlink.type, symlink.linkname = tarfile.SYMTYPE, '/owned'
        hardlink = tarfile.TarInfo('rootfs/hard')
        hardlink.type, hardlink.linkname = tarfile.LNKTYPE, 'rootfs/owned'
        data = tar([('metadata.yaml', b'ignored'), (file, b'X' * 15000),
                    ('rootfs/other', b'Y' * 15000), (symlink, None), (hardlink, None)])
        runtime = {'User': '1234:4321', 'Cmd': ['/owned'], 'Env': ['A=B'], 'WorkingDir': '/'}
        manifest, config, layers = self.response(Response(gzip.compress(data)), gzip.compress(data), runtime=runtime)
        self.assertEqual(manifest['config']['mediaType'], oci.CONFIG)
        self.assertNotIn('artifactType', manifest)
        self.assertNotIn('imageType', config)
        self.assertEqual(config['architecture'], 'riscv64')
        for key, value in runtime.items():
            self.assertEqual(config['config'][key], value)
        metadata = base64.b64decode(config['config']['Labels'][oci.METADATA_LABEL])
        with tarfile.open(fileobj=io.BytesIO(metadata)) as archive:
            self.assertEqual(archive.extractfile('metadata.yaml').read(), b'ignored')
        self.assertEqual(config['rootfs']['diff_ids'], [part['digest'] for part in manifest['layers']])
        self.assertGreater(len(layers), 1)
        members = {}
        for blob in layers:
            with tarfile.open(fileobj=io.BytesIO(blob)) as archive:
                members.update({member.name: member for member in archive})
        self.assertNotIn('metadata.yaml', members)
        self.assertEqual((members['owned'].uid, members['owned'].gid, members['owned'].mode), (1234, 4321, 0o6750))
        self.assertEqual(members['owned'].pax_headers['SCHILY.xattr.user.test'], 'preserved')
        self.assertEqual(members['link'].linkname, '/owned')
        self.assertEqual(members['hard'].linkname, 'owned')
        self.assertTrue(all(len(blob) <= 20480 for blob in layers))

    def test_hardlink_groups_are_colocated_and_overlarge_groups_fail(self):
        link = tarfile.TarInfo('rootfs/link')
        link.type, link.linkname = tarfile.LNKTYPE, 'rootfs/target'
        data = tar([('rootfs/target', b'T' * 15000), ('rootfs/filler', b'F' * 15000), (link, None)])
        _, _, blobs = self.response(Response(data), data)
        with tarfile.open(fileobj=io.BytesIO(blobs[-1])) as archive:
            self.assertEqual(archive.getnames(), ['target', 'link'])
            self.assertEqual(archive.extractfile('target').read(), b'T' * 15000)
        self.output = self.root / 'too-small'
        links = []
        for i in range(15):
            alias = tarfile.TarInfo(f'rootfs/link-{i}')
            alias.type, alias.linkname = tarfile.LNKTYPE, 'rootfs/target'
            links.append((alias, None))
        data = tar([('rootfs/target', b'T' * 15000), *links])
        with self.assertRaisesRegex(ValueError, 'Hardlink group'):
            self.response(Response(data), data)
        self.assertFalse(self.output.exists())

    def test_split_container_tar_and_short_multipart_reads(self):
        rootfs = tar([('file', b'\r\n--boundaryNOT-A-DELIMITER' + b'x' * 5000)])
        response = multipart([('metadata', 'meta.tar', self.metadata), ('rootfs', 'rootfs.tar', rootfs)])
        _, config, blobs = self.response(response, self.metadata + rootfs)
        self.assertEqual(config['config']['Cmd'], ['/bin/sh'])
        with tarfile.open(fileobj=io.BytesIO(blobs[0])) as archive:
            self.assertTrue(archive.extractfile('file').read().startswith(b'\r\n--boundaryNOT'))

    def test_compressed_unified_container_inputs(self):
        import bz2
        import lzma
        data = tar([('metadata.yaml', b'metadata'), ('rootfs/file', b'payload')])
        for compress in [gzip.compress, bz2.compress, lzma.compress]:
            with self.subTest(compress=compress):
                self.output = self.root / compress.__module__
                compressed = compress(data)
                _, _, layers = self.response(Response(compressed), compressed)
                with tarfile.open(fileobj=io.BytesIO(layers[0])) as archive:
                    self.assertEqual(archive.extractfile('file').read(), b'payload')

    def test_vm_split_and_unified_preserve_disk_metadata_and_templates(self):
        disk = b'QFI\xfb' + bytes(range(256)) * 80
        for unified in [False, True]:
            with self.subTest(unified=unified):
                self.output = self.root / str(unified)
                data = gzip.compress(tar([('metadata.yaml', b'architecture: x86_64\n'),
                                          ('templates/test.tpl', b'template'), ('rootfs.img', disk)]))
                response = Response(data) if unified else multipart([('metadata', 'meta.tar', self.metadata),
                                                                     ('rootfs.img', 'disk.qcow2', disk)])
                original = data if unified else self.metadata + disk
                manifest, config, blobs = self.response(response, original, vm=True, limit=4096)
                self.assertEqual(manifest['artifactType'], f'{oci.PREFIX}.vm.v1')
                self.assertNotIn('imageType', config)
                files = {file['role']: b''.join(blobs[i] for i in file['layers']) for file in config['files']}
                self.assertEqual(files['disk'], disk)
                if not unified:
                    self.assertEqual(files['metadata'], self.metadata)
                with tarfile.open(fileobj=io.BytesIO(files['metadata'])) as metadata:
                    self.assertEqual(metadata.extractfile('templates/test.tpl').read(), b'template')
                self.assertTrue(all(len(blob) <= 4096 for blob in blobs))

    def test_invalid_fingerprint_truncation_and_unsafe_names_leave_no_layout(self):
        payload = tar([('rootfs/file', b'payload')])
        for response, digest in [(Response(payload), '0' * 64),
                                  (multipart([('metadata', 'meta.tar', self.metadata)], complete=False), None),
                                  (multipart([('metadata', '../unsafe.tar', self.metadata)]), None),
                                  (Response(tar([('rootfs/../escape', b'x')])), None)]:
            with self.subTest(response=response):
                with self.assertRaises((ValueError, tarfile.TarError)):
                    self.response(response, payload, fingerprint=digest)
                self.assertFalse(self.output.exists())
                self.assertFalse(list(self.root.glob('.image-oci-*')))

    def test_oversized_entry_disk_full_and_existing_output(self):
        data = tar([('rootfs/huge', b'x' * 25000)])
        with self.assertRaisesRegex(ValueError, 'cannot be byte-split'):
            self.response(Response(data), data)
        self.assertFalse(self.output.exists())
        with patch.object(oci.LayerWriter, 'add', side_effect=OSError('disk full')):
            with self.assertRaisesRegex(OSError, 'disk full'):
                self.response(Response(data), data)
        self.assertFalse(list(self.root.glob('.image-oci-*')))
        self.output.mkdir()
        sentinel = self.output / 'keep'
        sentinel.write_text('unchanged')
        with self.assertRaises(FileExistsError):
            self.response(Response(data), data)
        self.assertEqual(sentinel.read_text(), 'unchanged')

    def test_linux_docker_export_preserves_runtime_without_image_save(self):
        runtime = {'User': '123:456', 'Env': ['FOO=bar'], 'WorkingDir': '/work',
                   'Cmd': ['test'], 'Entrypoint': ['/entry'], 'Labels': {'keep': 'yes'}}
        inspected = {'Id': 'sha256:' + 'a' * 64, 'Architecture': 'arm64', 'Os': 'linux',
                     'Variant': 'v8', 'Config': runtime, 'Created': '2026-01-01T00:00:00Z'}
        payload = tar([('old', b'F' * 15000), ('large', b'L' * 15000)])
        calls = []

        def run(arguments, **kwargs):
            calls.append(arguments)
            if arguments[1:3] == ['image', 'inspect']:
                return subprocess.CompletedProcess(arguments, 0, oci.encoded([inspected]))
            if arguments[1:3] == ['container', 'create']:
                self.assertEqual(arguments[-1], inspected['Id'])
                return subprocess.CompletedProcess(arguments, 0, 'export-container\n')
            self.assertEqual(arguments, ['docker', 'container', 'rm', '--volumes', 'export-container'])
            return subprocess.CompletedProcess(arguments, 0)

        @contextlib.contextmanager
        def stream(arguments):
            self.assertEqual(arguments, ['docker', 'container', 'export', 'export-container'])
            yield io.BytesIO(payload)

        with patch.object(oci.subprocess, 'run', side_effect=run), patch.object(oci, 'command_stream', stream):
            oci.convert_docker('original:tag', self.output, 20480)
        _, config, layers = read_layout(self.output)
        self.assertEqual(config['config'], runtime)
        self.assertEqual(config['variant'], 'v8')
        self.assertEqual(config['created'], inspected['Created'])
        self.assertGreater(len(layers), 1)
        self.assertFalse(any('save' in arguments or 'start' in arguments for arguments in calls))

    def test_linux_docker_export_failure_removes_container_and_partial_layout(self):
        inspected = {'Id': 'sha256:' + 'a' * 64, 'Architecture': 'amd64', 'Os': 'linux', 'Config': {}}
        calls = []

        def run(arguments, **kwargs):
            calls.append(arguments)
            if arguments[1:3] == ['image', 'inspect']:
                return subprocess.CompletedProcess(arguments, 0, oci.encoded([inspected]))
            return subprocess.CompletedProcess(arguments, 0, 'export-container\n')

        @contextlib.contextmanager
        def stream(arguments):
            yield io.BytesIO(tar([('large', b'L' * 15000)]))
            raise RuntimeError('export failed')

        with patch.object(oci.subprocess, 'run', side_effect=run), patch.object(oci, 'command_stream', stream):
            with self.assertRaisesRegex(RuntimeError, 'export failed'):
                oci.convert_docker('original:tag', self.output, 20480)
        self.assertEqual(calls[-1], ['docker', 'container', 'rm', '--volumes', 'export-container'])
        self.assertFalse(self.output.exists())
        self.assertFalse(list(self.root.glob('.image-oci-*')))

    def docker(self, modern=False, bad_digest=False, index_id=False, config_change=None, bad_config_hash=False):
        runtime = {'User': '123:456', 'Env': ['FOO=bar'], 'WorkingDir': '/work', 'Cmd': ['test'],
                   'Entrypoint': ['/entry'], 'Labels': {'keep': 'yes'}, 'StopSignal': 'SIGTERM'}
        first = tar([('old', b'old'), ('directory/keep', b'old')])
        second = tar([('directory/new', b'N' * 15000), ('old', b'new'),
                      ('directory/.wh..wh..opq', b''), ('large', b'L' * 15000)])
        config = {'architecture': 'arm64', 'os': 'linux', 'config': runtime,
                  'rootfs': {'type': 'layers', 'diff_ids': ['sha256:' + hashlib.sha256(data).hexdigest()
                                                         for data in [first, second]]},
                  'history': [{'created_by': 'first'}, {'created_by': 'ENV FOO', 'empty_layer': True},
                              {'created_by': 'second'}]}
        if config_change:
            config_change(config)
        data = oci.encoded(config)
        image_id = hashlib.sha256(data).hexdigest()
        if bad_config_hash:
            data += b'\n'
        config_name = f'blobs/sha256/{image_id}' if modern else f'{image_id}.json'
        paths = [f'blobs/sha256/{hashlib.sha256(layer).hexdigest()}' if modern else f'{i}/layer.tar'
                 for i, layer in enumerate([first, second])]
        manifest = [{'Config': config_name, 'RepoTags': ['unrelated:test'], 'Layers': paths}]
        if bad_digest:
            manifest[0]['Config'] = 'missing.json'
        archive = tar([(paths[1], second), (config_name, data), (paths[0], first),
                       ('manifest.json', oci.encoded(manifest)),
                       *([('blobs/sha256/' + 'a' * 64, b'{"schemaVersion":2}')] if modern else [])])
        with oci.Layout(self.output) as layout:
            platform = {'Os': 'linux', 'Architecture': 'arm64', 'RootFS': {'Layers': config['rootfs']['diff_ids']}}
            result, layers = oci.docker_archive(io.BytesIO(archive), layout, '0' * 64 if index_id else image_id,
                                                20480, 'linux', platform if index_id else None)
            layout.finish(result, layers)
        return runtime, read_layout(self.output)

    def test_docker_legacy_and_modern_preserve_runtime_and_whiteout_scope(self):
        for modern in [False, True]:
            with self.subTest(modern=modern):
                self.output = self.root / str(modern)
                runtime, (manifest, config, blobs) = self.docker(modern)
                self.assertEqual(runtime, config['config'])
                self.assertEqual(config['architecture'], 'arm64')
                self.assertEqual(len(config['rootfs']['diff_ids']), len(blobs))
                self.assertEqual(sum(not item.get('empty_layer') for item in config['history']), len(blobs))
                entries = []
                for blob in blobs:
                    with tarfile.open(fileobj=io.BytesIO(blob)) as archive:
                        entries.append(archive.getnames())
                opaque = next(i for i, names in enumerate(entries) if 'directory/.wh..wh..opq' in names)
                addition = next(i for i, names in enumerate(entries) if 'directory/new' in names)
                self.assertLess(opaque, addition)
                self.assertNotIn('artifactType', manifest)

    def test_docker_containerd_index_id_resolves_selected_platform(self):
        runtime, (_, config, _) = self.docker(modern=True, index_id=True)
        self.assertEqual(runtime, config['config'])

    def test_docker_wrong_identity_fails_atomically(self):
        with self.assertRaises(ValueError):
            self.docker(bad_digest=True)
        self.assertFalse(self.output.exists())

    def test_docker_rejects_inconsistent_source_digests_and_history(self):
        def corrupt_diffid(config):
            config['rootfs']['diff_ids'][0] = 'sha256:' + '0' * 64

        changes = [corrupt_diffid,
                   lambda config: config['rootfs']['diff_ids'].pop(),
                   lambda config: config['history'].pop(),
                   lambda config: config['history'].append({'created_by': 'extra layer'})]
        for change in changes:
            with self.subTest(change=change):
                with self.assertRaises(ValueError):
                    self.docker(config_change=change)
                self.assertFalse(self.output.exists())
                self.assertFalse(list(self.root.glob('.image-oci-*')))
        with self.assertRaisesRegex(ValueError, 'config digest mismatch'):
            self.docker(bad_config_hash=True)
        self.assertFalse(self.output.exists())

    def test_vm_export_preserves_sources_and_leaves_ci_outputs_untouched(self):
        exports = self.root / 'exports'
        exports.mkdir()
        (exports / 'meta-test.tar').write_bytes(self.metadata)
        disk = b'QFI\xfb' + b'\0' * 15000 + b'end'
        (exports / 'disk.qcow2').write_bytes(disk)
        before = {path: (path.stat().st_mtime_ns, path.read_bytes()) for path in exports.iterdir()}
        summary, output = self.root / 'summary', self.root / 'outputs'
        for path in [summary, output]:
            path.write_text('Existing content\n')
        with patch.dict(os.environ, GITHUB_STEP_SUMMARY=str(summary), GITHUB_OUTPUT=str(output)):
            oci.convert_lxd(self.output, 's390x', export_directory=exports, vm=True, limit=4096)
        manifest, config, layers = read_layout(self.output)
        self.assertEqual(before, {path: (path.stat().st_mtime_ns, path.read_bytes()) for path in exports.iterdir()})
        for path in [summary, output]:
            self.assertEqual(path.read_text(), 'Existing content\n')
        self.assertEqual(sorted(path.name for path in self.output.iterdir()), ['blobs', 'index.json', 'oci-layout'])
        entry = json.loads((self.output / 'index.json').read_bytes())['manifests'][0]
        expected_blobs = {entry['digest'], manifest['config']['digest'],
                          *[layer['digest'] for layer in manifest['layers']]}
        self.assertEqual(sorted(path.name for path in self.output.rglob('*') if path.is_file()),
                         sorted({'index.json', 'oci-layout', *[digest.split(':')[1] for digest in expected_blobs]}))
        files = {file['role']: b''.join(layers[i] for i in file['layers']) for file in config['files']}
        self.assertEqual(files, {'metadata': self.metadata, 'disk': disk})

    def test_windows_layers_and_runtime_config_remain_unchanged_within_limit(self):
        layer = tar([('Files/file', b'windows-data')])
        config = {'os': 'windows', 'architecture': 'amd64', 'os.version': '10.0.20348.0',
                  'config': {'User': 'ContainerAdministrator', 'Cmd': ['cmd', '/c', 'echo ok'], 'ArgsEscaped': True},
                  'rootfs': {'type': 'layers', 'diff_ids': ['sha256:' + hashlib.sha256(layer).hexdigest()]}}
        raw = oci.encoded(config)
        image_id = hashlib.sha256(raw).hexdigest()
        archive = tar([(f'{image_id}.json', raw), ('base/layer.tar', layer),
                       ('manifest.json', oci.encoded([{'Config': f'{image_id}.json', 'Layers': ['base/layer.tar']}]))])
        with oci.Layout(self.output) as layout:
            result, layers = oci.docker_archive(io.BytesIO(archive), layout, image_id, 20480, 'windows')
            self.assertEqual(result, config)
            layout.finish(result, layers)
        self.assertEqual(read_layout(self.output)[2], [layer])
        with self.assertRaisesRegex(ValueError, 'splitting Windows layers is unsupported'):
            with oci.Layout(self.root / 'oversized-windows') as layout:
                oci.docker_archive(io.BytesIO(archive), layout, image_id, 512, 'windows')

    def test_standalone_commands_run_outside_repository_without_ci_environment(self):
        helpers = Path(__file__).parents[1]
        env = {key: value for key, value in os.environ.items() if not key.startswith('GITHUB_')}
        for name in ['lxd-image-to-oci', 'lxd-vm-image-to-oci', 'docker-image-to-oci']:
            result = subprocess.run([str(helpers / name), '--help'], cwd=self.root, env=env,
                                    check=True, text=True, capture_output=True)
            self.assertNotIn('image-type', result.stdout)
            self.assertIn('--output-directory', result.stdout)
        exports = self.root / 'exports'
        exports.mkdir()
        (exports / 'image.tar').write_bytes(tar([('rootfs/file', b'content')]))
        subprocess.run([str(helpers / 'lxd-image-to-oci'), '--export-directory', str(exports),
                        '--output-directory', str(self.output), '--architecture', 's390x'],
                       cwd=self.root, env=env, check=True, capture_output=True)
        self.assertEqual(read_layout(self.output)[1]['architecture'], 's390x')


if __name__ == '__main__':
    unittest.main()
