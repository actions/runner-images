"""Prevent hosted-image toolsets from selecting pre-incident Go/Node SDKs."""

import json
from pathlib import Path
import shutil
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[1]
PATHS = [
    *sorted(ROOT.glob("byoi/toolsets/toolset-22*.json")),
    *sorted(ROOT.glob("byoi/toolsets/toolset-24*.json")),
    *sorted(ROOT.glob("images/ubuntu/toolsets/toolset-22*.json")),
    *sorted(ROOT.glob("images/ubuntu/toolsets/toolset-24*.json")),
    ROOT / "images/windows/toolsets/toolset-2022.json",
    ROOT / "images/windows/toolsets/toolset-2025.json",
    *sorted(ROOT.glob("images/macos/toolsets/toolset-*.json")),
]


class RuntimeSecurityToolsets(unittest.TestCase):
    @unittest.skipUnless(
        shutil.which("node"), "Node is required to execute the installer guard"
    )
    def test_macos_guard_rejects_pre_fix_runtimes(self):
        source = (ROOT / "images/macos/scripts/build/install-node.sh").read_text()
        guard = source.split("node <<'NODE'\n", 1)[1].split("\nNODE", 1)[0]
        harness = """
const assert = require('node:assert/strict');
const vm = require('node:vm');
const guard = require('node:fs').readFileSync(0, 'utf8');
for (const [version, rejected] of [
    ['20.19.2', true], ['22.23.3', true], ['22.23.4', false], ['22.24.0', false],
    ['24.22.0', true], ['24.22.1', false], ['26.12.0', true], ['26.12.1', false]
]) {
    let failed = false;
    vm.runInNewContext(guard, {process: {versions: {node: version}, exit: () => {failed = true;}}});
    assert.equal(failed, rejected, version);
}
"""
        subprocess.run(
            [shutil.which("node"), "-e", harness], input=guard, text=True, check=True
        )

    def test_supported_versions_and_matching_defaults(self):
        for path in PATHS:
            with self.subTest(toolset=str(path.relative_to(ROOT))):
                data = json.loads(path.read_text())
                tools = {tool["name"].lower(): tool for tool in data["toolcache"]}
                for name in ("go", "node"):
                    tool = tools[name]
                    variants = (
                        [tool]
                        if isinstance(tool.get("arch"), str)
                        else tool["arch"].values()
                    )
                    for variant in variants:
                        for version in variant["versions"]:
                            self.assertRegex(version, r"^\d+\.\d+\.\d+$")
                            major, minor, patch = map(int, version.split("."))
                            if name == "go":
                                self.assertEqual(major, 1)
                                self.assertTrue(
                                    minor > 27
                                    or (minor == 27 and patch >= 3)
                                    or (minor == 26 and patch >= 10),
                                    version,
                                )
                            else:
                                self.assertIn(major, (22, 24, 26))
                                self.assertGreaterEqual(
                                    (minor, patch),
                                    {22: (23, 4), 24: (22, 1), 26: (12, 1)}[major],
                                )
                    if tool.get("default"):
                        self.assertIn(tool["default"], tool["versions"])
                if "macos" not in path.parts:
                    self.assertIn(data["node"]["default"], tools["node"]["versions"])
                else:
                    # Homebrew accepts a major formula (node@22), not a patch name.
                    self.assertIn(data["node"]["default"], ("22", "24", "26"))


if __name__ == "__main__":
    unittest.main()
