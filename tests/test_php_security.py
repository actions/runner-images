import json
import os
from pathlib import Path
import re
import shutil
import subprocess
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
        code = re.search(r"/bin/php\" -r '\n(.*?)\n    '", path.read_text(), re.S)
        self.assertIsNotNone(code)
        function = code.group(1).split('        if (!phpSecurityVersionIsFixed(PHP_VERSION))')[0]
        program = function + '\nforeach (json_decode($argv[1], true) as $v => $expected) {' \
            'if (phpSecurityVersionIsFixed($v) !== $expected) {fwrite(STDERR, $v); exit(1);}}'
        result = subprocess.run(['php', '-r', program, json.dumps(UPSTREAM_CASES)],
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == '__main__':
    unittest.main()
