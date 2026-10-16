#!/usr/bin/env python3
"""Run an act workflow in a disposable instance of a built Ubuntu image."""

import argparse
import json
import os
from pathlib import Path
import re
import shlex
import signal
import subprocess
import tempfile
import time
import uuid
import xml.etree.ElementTree as ET


def run(arguments, timeout=300, **kwargs):
    print('+ ' + shlex.join(str(argument) for argument in arguments), flush=True)
    return subprocess.run(arguments, check=True, timeout=timeout, **kwargs)


def docker_image(manifest_path, image_os):
    manifest = json.loads(Path(manifest_path).read_text())
    if not manifest.get('last_run_uuid'):
        raise ValueError('Packer manifest does not identify its latest run.')
    builds = [build for build in manifest['builds']
              if build.get('packer_run_uuid') == manifest.get('last_run_uuid')
              and build.get('builder_type') == 'docker'
              and build.get('custom_data', {}).get('image_os') == image_os]
    if len(builds) != 1 or not re.fullmatch(r'sha256:[0-9a-f]{64}', builds[0].get('artifact_id', '')):
        raise ValueError('Packer manifest does not identify exactly one matching committed Docker image.')
    return builds[0]['artifact_id']


def test_image(backend, instance_type, image_os, act_binary, manifest_path='packer-manifest.json', junit_output=None):
    started = time.monotonic()
    failure = None
    try:
        _test_image(backend, instance_type, image_os, act_binary, manifest_path)
    except BaseException as error:
        failure = error
        raise
    finally:
        if junit_output:
            duration = f'{time.monotonic() - started:.3f}'
            suite = ET.Element('testsuite', name='image-runtime', tests='1',
                               failures=str(int(failure is not None)), errors='0', skipped='0', time=duration)
            case = ET.SubElement(suite, 'testcase', classname=f'{image_os}.{backend}.{instance_type}',
                                 name='act smoke workflow', time=duration)
            if failure is not None:
                ET.SubElement(case, 'failure', type=type(failure).__name__,
                              message=str(failure)).text = str(failure)
            ET.ElementTree(suite).write(junit_output, encoding='utf-8', xml_declaration=True)


def _test_image(backend, instance_type, image_os, act_binary, manifest_path):
    if not re.fullmatch(r'ubuntu(22|24|26)(-arm64)?', image_os):
        raise ValueError('Runtime workflow tests currently support Ubuntu images only.')
    if backend not in ('lxd', 'docker') or instance_type not in ('container', 'vm'):
        raise ValueError('Unsupported image backend or instance type.')
    if backend == 'docker' and instance_type != 'container':
        raise ValueError('Docker runtime tests require a container image.')
    token = os.environ.get('GITHUB_TOKEN', '')
    if not token or '\n' in token or '\r' in token:
        raise ValueError('A read-only GITHUB_TOKEN is required for the checkout smoke test.')
    act_binary = Path(act_binary).resolve(strict=True)
    fixture = Path(__file__).resolve().parent / 'runtime-tests'
    name = 'image-smoke-' + uuid.uuid4().hex[:12]
    guest = '/opt/' + name
    created = False
    success = False
    try:
        if backend == 'lxd':
            alias = image_os + ('-vm' if instance_type == 'vm' else '')
            launch = ['lxc', 'launch', alias, name]
            if instance_type == 'vm':
                launch.append('--vm')
            # Clean up even if launch creates an instance and then fails to start it.
            created = True
            # Unpacking a complete runner disk can exceed five minutes before boot starts.
            run(launch, timeout=1800)
            execute = ['lxc', 'exec', name, '--']
            deadline = time.monotonic() + 180
            while True:
                try:
                    subprocess.run([*execute, 'true'], check=True, timeout=20,
                                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                    break
                except (subprocess.CalledProcessError, subprocess.TimeoutExpired):
                    if time.monotonic() >= deadline:
                        raise RuntimeError('Timed out waiting for the LXD instance agent.')
                    time.sleep(3)
            run([*execute, 'bash', '-c',
                 'if command -v cloud-init >/dev/null; then cloud-init status --wait || [ $? -eq 2 ]; fi'])
        else:
            image = docker_image(manifest_path, image_os)
            created = True
            run(['docker', 'create', '--name', name, '--user', '0', '--entrypoint', '/bin/sleep', image, 'infinity'])
            run(['docker', 'start', name])
            execute = ['docker', 'exec', '--user', '0', name]

        run([*execute, 'mkdir', '-p', guest + '/workflow'])

        def copy(source, destination):
            if backend == 'lxd':
                arguments = ['lxc', 'file', 'push']
                if Path(source).is_dir():
                    arguments.append('--recursive')
                    source = str(source) + '/'
                run([*arguments, str(source), name + destination])
            else:
                run(['docker', 'cp', str(source), name + ':' + destination])

        for source in sorted(fixture.iterdir()):
            copy(source, guest + '/workflow/')
        copy(act_binary, guest + '/act')
        with tempfile.TemporaryDirectory(prefix='image-smoke-secrets-') as temporary:
            secrets = Path(temporary) / 'secrets'
            secrets.write_text('GITHUB_TOKEN=' + token + '\n')
            secrets.chmod(0o600)
            copy(secrets, guest + '/secrets')

        run([*execute, 'chmod', '0755', guest + '/act'])
        run([*execute, 'chown', '-R', 'packer:packer', guest])
        # Use the same unprivileged build account as Homebrew and upstream image tests.
        command = 'set -euo pipefail\ncd ' + shlex.quote(guest + '/workflow') + '\n'
        command += '''git init --quiet
git -c user.name=ImageSmoke -c user.email=image-smoke@localhost add .
git -c user.name=ImageSmoke -c user.email=image-smoke@localhost commit --quiet -m fixture
git remote add origin https://github.com/vicamo/runner-images.git
'''
        command += shlex.join([
            guest + '/act', 'push', '--workflows', 'workflow.yml',
            '--platform', 'ubuntu-latest=-self-hosted', '--pull=false',
            '--env', 'IMAGE_SMOKE_FIXTURE=' + guest + '/workflow',
            '--secret-file', guest + '/secrets', '--env-file', '/dev/null',
            '--var-file', '/dev/null', '--input-file', '/dev/null',
            '--action-cache-path', guest + '/cache',
        ])
        print('Running workflow inside the built image as packer.', flush=True)
        subprocess.run([*execute, 'su', '--login', 'packer', '--shell', '/bin/bash', '--command', command],
                       check=True, timeout=1200)
        success = True
    finally:
        cleanup_error = None
        if created:
            cleanup = (['lxc', 'delete', '--force', name] if backend == 'lxd'
                       else ['docker', 'rm', '--force', name])
            try:
                run(cleanup)
            except (subprocess.SubprocessError, OSError) as error:
                if success:
                    success = False
                    cleanup_error = error
                print('Warning: Failed to remove runtime test instance ' + name, flush=True)
        if cleanup_error:
            raise cleanup_error


def terminate(signum, frame):
    raise SystemExit(128 + signum)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--backend', required=True, choices=['lxd', 'docker'])
    parser.add_argument('--instance-type', required=True, choices=['container', 'vm'])
    parser.add_argument('--image-os', required=True)
    parser.add_argument('--act-binary', required=True)
    parser.add_argument('--manifest', default='packer-manifest.json')
    parser.add_argument('--junit-output', help='Write the aggregate smoke workflow result as JUnit XML')
    args = parser.parse_args()
    signal.signal(signal.SIGTERM, terminate)
    test_image(args.backend, args.instance_type, args.image_os, args.act_binary, args.manifest, args.junit_output)
