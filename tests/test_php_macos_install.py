"""Exercise the real macOS installer with an isolated Homebrew/Cellar fixture."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

BREW_STUB = r"""#!/usr/bin/env python3
import json
import os
from pathlib import Path
import shutil
import sys

root = Path(os.environ['PHP_TEST_ROOT'])
state_file = root / 'state.json'
state = json.loads(state_file.read_text())
args = sys.argv[1:]
with (root / 'commands.log').open('a') as log:
    log.write(' '.join(args) + '\n')
command = args[0]
if state.get('fail') == command:
    sys.exit(23)

def formula(name):
    return state.get('aliases', {}).get(name, name)

def make_keg(name, version):
    binary = root / 'Cellar' / name / version / 'bin/php'
    binary.parent.mkdir(parents=True, exist_ok=True)
    branch = '.'.join(version.split('.')[:2])
    status = 42 if version in state.get('vulnerable', []) else 0
    binary.write_text('#!/bin/sh\n'
        + 'printf "%s\\n" ' + repr(str(binary)) + ' >> "$PHP_TEST_ROOT/binaries.log"\n'
        + 'if [ "$2" = \'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;\' ]; then\n'
        + '  printf "%s" ' + repr(branch) + '\nelse\n  exit ' + str(status) + '\nfi\n')
    binary.chmod(0o755)

if command == 'list':
    print('\n'.join(state['installed']))
elif command == 'info':
    name = formula(args[-1])
    print(json.dumps({'formulae': [{'versions': {'stable': state['candidates'][name]}}]}))
elif command == '--prefix':
    name = formula(args[1])
    print(root / 'Cellar' / name / state['installed'][name])
elif command == '--cellar':
    print(root / 'Cellar' / formula(args[1]))
elif command == 'install':
    name = formula(args[-1])
    if name == 'composer' and state.get('composer_upgrade_version'):
        state['installed']['php'] = state['composer_upgrade_version']
        make_keg('php', state['composer_upgrade_version'])
    if name != 'composer' and name not in state['installed'] and not state.get('skip_install'):
        state['installed'][name] = state['candidates'][name]
        make_keg(name, state['installed'][name])
elif command == 'upgrade':
    name = formula(args[-1])
    state['installed'][name] = state.get('upgrade_version', state['candidates'][name])
    make_keg(name, state['installed'][name])
elif command == 'cleanup':
    name = formula(args[-1])
    if not state.get('skip_cleanup'):
        for keg in (root / 'Cellar' / name).iterdir():
            if keg.name != state['installed'][name]:
                shutil.rmtree(keg)
else:
    sys.exit('Unexpected brew command: ' + repr(args))
state_file.write_text(json.dumps(state))
"""


@unittest.skipUnless(shutil.which("jq"), "Homebrew installer requires jq")
class PhpMacosInstallerTests(unittest.TestCase):
    def run_installer(self, **overrides):
        state = {
            "installed": {"php": "8.5.11"},
            "aliases": {"php@8.5": "php"},
            "candidates": {"php": "8.5.12"},
            "vulnerable": ["8.5.11"],
        }
        state.update(overrides)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            (root / "state.json").write_text(json.dumps(state))
            (root / "utils").mkdir()
            (root / "utils/utils.sh").write_text(
                'get_toolset_value() { echo "${PHP_TEST_BRANCH:-8.5}"; }\n'
                'brew_smart_install() { brew install "$1"; }\n'
                "invoke_tests() { :; }\n"
            )
            (root / "bin").mkdir()
            brew = root / "bin/brew"
            brew.write_text(BREW_STUB)
            brew.chmod(0o755)
            env = dict(
                os.environ,
                HOME=str(root),
                PHP_TEST_ROOT=str(root),
                PHP_TEST_BRANCH=state.get("configured_branch", "8.5"),
                HOMEBREW_NO_INSTALL_CLEANUP="1",
                PATH=str(root / "bin") + os.pathsep + os.environ["PATH"],
            )
            # Seed the installed kegs using the same fixture as the upgrade.
            seeder = BREW_STUB[: BREW_STUB.index("if command == 'list':")]
            seeder += '\nfor name, version in state["installed"].items():\n    make_keg(name, version)\n'
            subprocess.run(["python3", "-c", seeder, "seed"], env=env, check=True)
            result = subprocess.run(
                [
                    "/bin/bash",
                    "-e",
                    "-o",
                    "pipefail",
                    str(ROOT / "images/macos/scripts/build/install-php.sh"),
                ],
                env=env,
                capture_output=True,
                text=True,
            )
            commands = (root / "commands.log").read_text()
            binaries = (
                (root / "binaries.log").read_text()
                if (root / "binaries.log").exists()
                else ""
            )
            remaining = [
                str(p.relative_to(root)) for p in (root / "Cellar").glob("**/bin/php")
            ]
            return result, commands, binaries, remaining

    def test_upgrade_removes_old_kegs_despite_disabled_automatic_cleanup(self):
        result, commands, _, remaining = self.run_installer()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("cleanup --prune=all php", commands)
        self.assertEqual(remaining, ["Cellar/php/8.5.12/bin/php"])

    def test_every_remaining_keg_is_checked(self):
        result, _, binaries, _ = self.run_installer(skip_cleanup=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("/php/8.5.11/bin/php", binaries)

    def test_command_failures_stop_the_build(self):
        for command in ["list", "info", "upgrade", "cleanup", "--prefix", "--cellar"]:
            with self.subTest(command=command):
                result, _, _, _ = self.run_installer(fail=command)
                self.assertNotEqual(result.returncode, 0)

    def test_existing_unversioned_runtime_cannot_change_branch(self):
        result, commands, _, _ = self.run_installer(installed={"php": "8.4.26"})
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("install ", commands)
        self.assertNotIn("upgrade ", commands)

    def test_configured_alias_cannot_select_another_branch(self):
        result, commands, _, _ = self.run_installer(candidates={"php": "9.0.0"})
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("install ", commands)

    def test_unexpected_upgrade_branch_fails_the_postcondition(self):
        result, _, _, _ = self.run_installer(upgrade_version="9.0.0")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("release branch changed", result.stderr)

    def test_composer_cannot_change_an_existing_php_release_branch(self):
        result, commands, _, _ = self.run_installer(composer_upgrade_version="9.0.0")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(
            "release branch changed while installing PHP or Composer", result.stderr
        )
        self.assertNotIn("upgrade ", commands)

    def test_versioned_and_composer_php_formulas_are_both_checked(self):
        result, commands, _, remaining = self.run_installer(
            installed={"php": "8.5.11", "php@8.4": "8.4.26"},
            candidates={"php": "8.5.12", "php@8.4": "8.4.27"},
            vulnerable=["8.5.11", "8.4.26"],
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("upgrade --formula php@8.4", commands)
        self.assertEqual(
            set(remaining),
            {"Cellar/php/8.5.12/bin/php", "Cellar/php@8.4/8.4.27/bin/php"},
        )

    def test_patch_upgrades_preserve_all_supported_release_branches(self):
        for branch, old, fixed in [
            ("8.2", "8.2.34", "8.2.35"),
            ("8.3", "8.3.35", "8.3.36"),
            ("8.4", "8.4.26", "8.4.27"),
            ("8.5", "8.5.11", "8.5.12"),
        ]:
            with self.subTest(branch=branch):
                formula = "php@" + branch
                result, _, _, remaining = self.run_installer(
                    installed={formula: old},
                    aliases={},
                    candidates={formula: fixed},
                    vulnerable=[old],
                    configured_branch=branch,
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(
                    remaining, ["Cellar/" + formula + "/" + fixed + "/bin/php"]
                )

    def test_empty_installed_inventory_fails(self):
        result, _, _, _ = self.run_installer(installed={}, skip_install=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("No installed PHP formula", result.stderr)

    def test_fully_qualified_php_formula_is_checked(self):
        result, commands, _, _ = self.run_installer(
            installed={"php": "8.5.11", "vendor/tap/php@8.3": "8.3.35"},
            candidates={"php": "8.5.12", "vendor/tap/php@8.3": "8.3.36"},
            vulnerable=["8.5.11", "8.3.35"],
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("upgrade --formula vendor/tap/php@8.3", commands)


if __name__ == "__main__":
    unittest.main()
