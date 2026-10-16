import contextlib
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from unittest.mock import patch


spec = importlib.util.spec_from_file_location('image_runtime', Path(__file__).parents[1] / 'test_image_workflow.py')
runtime = importlib.util.module_from_spec(spec)
spec.loader.exec_module(runtime)


class RuntimeTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='image-runtime-test-')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.act = self.root / 'act'
        self.act.touch()
        self.manifest = self.root / 'manifest.json'
        self.image = 'sha256:' + 'a' * 64
        self.manifest.write_text(json.dumps({
            'last_run_uuid': 'current',
            'builds': [
                {'name': 'ubuntu-24_04', 'builder_type': 'docker', 'packer_run_uuid': 'old',
                 'artifact_id': 'sha256:' + 'b' * 64, 'custom_data': {'image_os': 'ubuntu24'}},
                {'name': 'ubuntu-24_04', 'builder_type': 'docker', 'packer_run_uuid': 'current',
                 'artifact_id': self.image, 'custom_data': {'image_os': 'ubuntu24'}},
            ],
        }))
        self.calls = []
        self.timeouts = []
        self.failure = None

    def execute(self, arguments, **kwargs):
        self.calls.append(arguments)
        self.timeouts.append(kwargs.get('timeout'))
        if self.failure == 'launch' and arguments[:2] == ['lxc', 'launch']:
            raise subprocess.CalledProcessError(1, arguments)
        if self.failure == 'workflow' and 'su' in arguments:
            raise subprocess.TimeoutExpired(arguments, 1200)
        if self.failure == 'cleanup' and arguments[:2] == ['docker', 'rm']:
            raise subprocess.CalledProcessError(1, arguments)
        return subprocess.CompletedProcess(arguments, 0)

    def test_manifest_uses_exact_current_build(self):
        self.assertEqual(runtime.docker_image(self.manifest, 'ubuntu24'), self.image)
        for image_os in ['ubuntu22', 'ubuntu24-arm64']:
            with self.assertRaises(ValueError):
                runtime.docker_image(self.manifest, image_os)

    def smoke(self, backend, instance='container'):
        with patch.dict(os.environ, GITHUB_TOKEN='test-only-token'):
            with patch.object(runtime.subprocess, 'run', side_effect=self.execute):
                with contextlib.redirect_stdout(io.StringIO()):
                    runtime.test_image(backend, instance, 'ubuntu24', self.act, self.manifest, self.root / 'result.xml')

    def assert_result(self, failed, backend='docker'):
        suite = ET.parse(self.root / 'result.xml').getroot()
        self.assertEqual(suite.tag, 'testsuite')
        self.assertEqual(suite.get('tests'), '1')
        self.assertEqual(suite.get('failures'), str(int(failed)))
        self.assertGreaterEqual(float(suite.get('time')), 0)
        case = suite.find('testcase')
        self.assertEqual(case.get('classname'), f'ubuntu24.{backend}.container')
        self.assertEqual(case.find('failure') is not None, failed)
        self.assertNotIn('test-only-token', (self.root / 'result.xml').read_text())

    def test_validation_failure_produces_junit_result(self):
        with self.assertRaises(ValueError):
            runtime.test_image('invalid', 'container', 'ubuntu24', self.act,
                               self.manifest, self.root / 'result.xml')
        suite = ET.parse(self.root / 'result.xml').getroot()
        self.assertEqual(suite.get('failures'), '1')
        self.assertEqual(suite.find('testcase/failure').get('type'), 'ValueError')

    def test_junit_escapes_failure_details_and_preserves_exception(self):
        error = RuntimeError('invalid <disk> & state')
        with patch.object(runtime, '_test_image', side_effect=error):
            with self.assertRaises(RuntimeError) as caught:
                runtime.test_image('docker', 'container', 'ubuntu24', self.act,
                                   self.manifest, self.root / 'result.xml')
        self.assertIs(caught.exception, error)
        failure = ET.parse(self.root / 'result.xml').find('testcase/failure')
        self.assertEqual(failure.get('message'), str(error))
        self.assertEqual(failure.text, str(error))

    def test_docker_launches_exact_image_and_removes_only_test_container(self):
        self.smoke('docker')
        create = self.calls[0]
        self.assertEqual(create[:2], ['docker', 'create'])
        self.assertIn(self.image, create)
        name = create[create.index('--name') + 1]
        self.assertTrue(name.startswith('image-smoke-'))
        self.assertEqual(self.calls[-1], ['docker', 'rm', '--force', name])
        execution = next(call for call in self.calls if 'su' in call)
        self.assertIn('packer', execution)
        self.assertIn('ubuntu-latest=-self-hosted', execution[-1])
        self.assertNotIn('test-only-token', repr(self.calls))
        self.assert_result(False)

    def test_lxd_vm_alias_agent_wait_and_directory_copy(self):
        self.smoke('lxd', 'vm')
        self.assertEqual(self.calls[0][:3], ['lxc', 'launch', 'ubuntu24-vm'])
        self.assertEqual(self.calls[0][-1], '--vm')
        self.assertEqual(self.timeouts[0], 1800)
        name = self.calls[0][3]
        self.assertIn(['lxc', 'exec', name, '--', 'true'], self.calls)
        copy = next(call for call in self.calls if call[:3] == ['lxc', 'file', 'push'] and call[-2].endswith('/action/'))
        self.assertEqual(copy[-1], name + '/opt/' + name + '/workflow/')
        self.assertEqual(self.calls[-1], ['lxc', 'delete', '--force', name])

    def test_workflow_timeout_cleans_up_and_fails(self):
        self.failure = 'workflow'
        with self.assertRaises(subprocess.TimeoutExpired):
            self.smoke('docker')
        self.assertEqual(self.calls[-1][:3], ['docker', 'rm', '--force'])
        self.assert_result(True)

    def test_failed_launch_attempt_cleans_up_partial_instance(self):
        self.failure = 'launch'
        with self.assertRaises(subprocess.CalledProcessError):
            self.smoke('lxd')
        self.assertEqual(self.calls[-1][:3], ['lxc', 'delete', '--force'])
        self.assertEqual(self.calls[-1][-1], self.calls[0][3])
        self.assert_result(True, backend='lxd')

    def test_cleanup_failure_blocks_success(self):
        self.failure = 'cleanup'
        with self.assertRaises(subprocess.CalledProcessError):
            self.smoke('docker')
        self.assert_result(True)


if __name__ == '__main__':
    unittest.main()
