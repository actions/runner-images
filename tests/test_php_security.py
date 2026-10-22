import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
HELPERS = [p for p in (
    ROOT / 'images/ubuntu/scripts/helpers/php-security.sh',
    ROOT / 'byoi/scripts/helpers/php-security.sh',
    ROOT / 'ansible/security/files/php-security.sh',
) if p.is_file()]

UPSTREAM_CASES = {
    '8.2.34': False, '8.2.35': True, '8.2.36': True,
    '8.3.35': False, '8.3.36': True, '8.3.37': True,
    '8.4.26': False, '8.4.27': True, '8.4.28': True,
    '8.5.11': False, '8.5.12': True, '8.5.13': True,
    '8.1.34': False, '7.4.33': False, '8.6.0': True, '9.0.0': True,
    '8.3.36RC1': False, '8.3.36-rc1': False, '8.6.0~rc1': False, '8.6.0-dev': False, 'not-a-version': False,
    '8.5.12-alpha.1': False, '8.6.0-beta.1': False,
    '8.5.12-Rc1': False, '8.5.12-devubuntu1': False,
}


class PhpSecurityTests(unittest.TestCase):
    def call(self, helper, function, *args, env=None):
        return subprocess.run(
            ['bash', '-c', 'source "$1"; shift; "$@"', 'php-security-test',
             str(helper), function, *args],
            capture_output=True, text=True, env=env,
        )

    def test_upstream_patch_boundaries_and_future_stable_releases(self):
        self.assertTrue(HELPERS, 'No PHP security helper found')
        for helper in HELPERS:
            for version, expected in UPSTREAM_CASES.items():
                with self.subTest(helper=helper, version=version):
                    result = self.call(helper, 'php_security_upstream_fixed', version)
                    self.assertEqual(result.returncode == 0, expected, result.stderr)

    @unittest.skipUnless(shutil.which('dpkg'), 'Ubuntu package comparisons require dpkg')
    def test_vendor_backports_require_the_matching_ubuntu_revision_family(self):
        cases = [
            ('22.04', '8.1', '8.1.2-1ubuntu2.27', False),
            ('22.04', '8.1', '8.1.2-1ubuntu2.28', True),
            ('22.04', '8.1', '8.1.2-1ubuntu2.29', True),
            ('24.04', '8.3', '8.3.6-0ubuntu0.24.04.12', False),
            ('24.04', '8.3', '8.3.6-0ubuntu0.24.04.13', True),
            ('24.04', '8.3', '8.3.6-0ubuntu0.24.04.14', True),
            ('26.04', '8.5', '8.5.4-0ubuntu1.4', False),
            ('26.04', '8.5', '8.5.4-0ubuntu1.5', True),
            ('26.10', '8.5', '8.5.9-0ubuntu2.0', False),
            ('26.10', '8.5', '8.5.9-0ubuntu2.1', True),
            ('22.04', '8.1', '8.1.34-1+ubuntu22.04.1+deb.sury.org+1', False),
            ('24.04', '8.3', '8.3.6-1+ubuntu24.04.1+deb.sury.org+1', False),
            ('24.04', '8.1', '8.1.2-1ubuntu2.28', False),
            ('28.04', '8.3', '8.3.6-0ubuntu0.24.04.13', False),
        ]
        for helper in HELPERS:
            for release, branch, version, expected in cases:
                with self.subTest(helper=helper, release=release, version=version):
                    result = self.call(helper, 'php_security_ubuntu_fixed', release, branch, version)
                    self.assertEqual(result.returncode == 0, expected, result.stderr)

    @unittest.skipUnless(Path('/etc/os-release').is_file(), 'Linux package inventory required')
    def test_inventory_checks_fpm_even_when_cli_is_patched(self):
        cases = [
            ('installed\tphp8.3-cli\tphp8.3\t8.3.36-1\n'
             'installed\tphp8.3-fpm\tphp8.3\t8.3.35-1\n', 0, False),
            ('installed\tphp8.3-cli\tphp8.3\t8.3.36-1\n'
             'installed\tphp8.3-fpm\tphp8.3\t8.3.36-1\n'
             'installed\tlibapache2-mod-php8.3\tphp8.3\t8.3.36-1\n', 0, True),
            ('config-files\tphp8.1-fpm\tphp8.1\t8.1.2-1ubuntu2.27\n'
             'installed\tphp8.3-cli\tphp8.3\t8.3.36-1\n', 0, True),
            ('installed\tphp8.3-cli\tphp8.3\t8.3.36-1\n', 2, False),
            ('', 0, False),
        ]
        with tempfile.TemporaryDirectory() as directory:
            stub = Path(directory) / 'dpkg-query'
            stub.write_text('#!/bin/sh\nprintf "%s" "$PHP_TEST_PACKAGES"\nexit "$PHP_TEST_QUERY_STATUS"\n')
            stub.chmod(0o755)
            for helper in HELPERS:
                for packages, status, expected in cases:
                    with self.subTest(helper=helper, packages=packages, status=status):
                        env = dict(os.environ, PATH=directory + os.pathsep + os.environ['PATH'],
                                   PHP_TEST_PACKAGES=packages, PHP_TEST_QUERY_STATUS=str(status))
                        result = self.call(helper, 'php_security_check_installed', env=env)
                        self.assertEqual(result.returncode == 0, expected, result.stderr)

    @unittest.skipUnless(shutil.which('php'), 'PHP CLI required for macOS guard policy test')
    def test_macos_guard_rejects_old_and_prerelease_versions(self):
        path = ROOT / 'images/macos/scripts/build/install-php.sh'
        if not path.is_file():
            self.skipTest('No macOS builder in this repository')
        code = re.search(r"\"\$phpBinary\" -r '\n(.*?)\n    '", path.read_text(), re.S)
        self.assertIsNotNone(code)
        function = code.group(1).split('        if (!phpSecurityVersionIsFixed(PHP_VERSION))')[0]
        program = function + '\nforeach (json_decode($argv[1], true) as $v => $expected) {' \
            'if (phpSecurityVersionIsFixed($v) !== $expected) {fwrite(STDERR, $v); exit(1);}}'
        result = subprocess.run(['php', '-r', program, json.dumps(UPSTREAM_CASES)],
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)


class PhpInstallerTests(unittest.TestCase):
    INSTALLERS = [p for p in (
        ROOT / 'images/ubuntu/scripts/build/install-php.sh',
        ROOT / 'byoi/scripts/build/install-php.sh',
    ) if p.is_file()]

    def run_installer(self, installer, versions, *, apt_failure='', security_status=0):
        # Execute the real installer with isolated commands: no packages, files or
        # network resources on the machine running these tests are changed.
        with tempfile.TemporaryDirectory() as directory:
            directory = Path(directory)
            helpers = directory / 'helpers'
            helpers.mkdir()
            log = directory / 'commands.jsonl'
            log.touch()
            (helpers / 'etc-environment.sh').write_text(
                'prepend_etc_environment_path() { :; }\n')
            (helpers / 'os.sh').write_text('')
            (helpers / 'install.sh').write_text(
                'get_toolset_value() { printf "%s\\n" "$PHP_TEST_VERSIONS"; }\n'
                'invoke_tests() { :; }\n')
            (helpers / 'php-security.sh').write_text(
                'php_security_check_installed() {\n'
                '    printf \'["security-check"]\\n\' >> "$PHP_TEST_COMMAND_LOG"\n'
                '    return "$PHP_TEST_SECURITY_STATUS"\n'
                '}\n')
            command = directory / 'mock-command'
            command.write_text(
                '#!' + sys.executable + '\n'
                'import json, os, sys\n'
                'from pathlib import Path\n'
                'name = Path(sys.argv[0]).name\n'
                'with open(os.environ["PHP_TEST_COMMAND_LOG"], "a") as output:\n'
                '    output.write(json.dumps([name] + sys.argv[1:]) + "\\n")\n'
                'if name == "apt-get":\n'
                '    if sys.argv[1] == os.environ["PHP_TEST_APT_FAILURE"]:\n'
                '        sys.exit(42)\n'
                # Neither package exists in Ubuntu 26.04 main/universe. Failing
                # here reproduces the actual package-resolution failure.
                '    if {"php8.5-imap", "php8.5-opcache"}.intersection(sys.argv):\n'
                '        sys.exit(43)\n')
            command.chmod(0o755)
            for name in ('apt-get', 'phpdismod', 'php', 'sudo', 'mkdir', 'wget', 'install'):
                (directory / name).symlink_to(command)
            env = dict(os.environ, PATH=str(directory) + os.pathsep + os.environ['PATH'],
                       HELPER_SCRIPTS=str(helpers), PHP_TEST_COMMAND_LOG=str(log),
                       PHP_TEST_VERSIONS=' '.join(versions), PHP_TEST_APT_FAILURE=apt_failure,
                       PHP_TEST_SECURITY_STATUS=str(security_status))
            result = subprocess.run(['bash', '-e', str(installer)], cwd=directory,
                                    capture_output=True, text=True, env=env)
            commands = [json.loads(line) for line in log.read_text().splitlines()]
            return result, commands

    def test_configured_branches_keep_their_runtimes_and_validate_before_downloads(self):
        self.assertTrue(self.INSTALLERS, 'No Linux PHP installer found')
        for installer in self.INSTALLERS:
            toolsets = installer.parents[2] / 'toolsets'
            versions = sorted({str(version) for toolset in toolsets.glob('*.json')
                               for version in json.loads(toolset.read_text()).get('php', {}).get('versions', [])})
            self.assertTrue(versions, f'No PHP toolsets found for {installer}')
            for version in versions:
                with self.subTest(installer=installer, version=version):
                    result, commands = self.run_installer(installer, [version])
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertEqual(commands[0], ['apt-get', 'update'])
                    packages = {arg for command in commands if command[:2] == ['apt-get', 'install']
                                for arg in command[2:] if not arg.startswith('-')}
                    branches = {match.group(1) for package in packages
                                if (match := re.match(r'^php(\d+\.\d+)(?:-|$)', package))}
                    self.assertEqual(branches, {version})
                    for sapi in ('cli', 'cgi', 'fpm', 'common'):
                        self.assertIn(f'php{version}-{sapi}', packages)
                    if version in ('8.1', '8.3'):
                        self.assertIn(f'php{version}-imap', packages)
                        self.assertIn(f'php{version}-opcache', packages)
                    if version == '8.5':
                        self.assertNotIn('php8.5-imap', packages)
                        self.assertNotIn('php8.5-opcache', packages)
                    validation = commands.index(['security-check'])
                    install_positions = [i for i, c in enumerate(commands) if c[:2] == ['apt-get', 'install']]
                    self.assertGreater(validation, max(install_positions))
                    self.assertGreater(next(i for i, c in enumerate(commands) if c[0] == 'php'), validation)

    def test_apt_failures_stop_before_validation_or_downloads(self):
        for installer in self.INSTALLERS:
            for operation in ('update', 'install'):
                with self.subTest(installer=installer, operation=operation):
                    result, commands = self.run_installer(installer, ['8.3'], apt_failure=operation)
                    self.assertEqual(result.returncode, 42, result.stderr)
                    self.assertNotIn(['security-check'], commands)
                    self.assertFalse(any(c[0] in ('php', 'wget') for c in commands))

    def test_unverified_runtime_stops_before_composer_and_phpunit_downloads(self):
        for installer in self.INSTALLERS:
            with self.subTest(installer=installer):
                result, commands = self.run_installer(installer, ['8.3'], security_status=23)
                self.assertEqual(result.returncode, 23, result.stderr)
                self.assertIn(['security-check'], commands)
                self.assertFalse(any(c[0] in ('php', 'wget') for c in commands))


if __name__ == '__main__':
    unittest.main()
