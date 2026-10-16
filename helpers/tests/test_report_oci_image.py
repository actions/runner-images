import contextlib
import importlib.util
from importlib.machinery import SourceFileLoader
import io
from pathlib import Path
import tarfile
import tempfile
import unittest
from unittest.mock import patch


def load(name, filename=None):
    path = Path(__file__).parents[1] / (filename or (name + '.py'))
    spec = importlib.util.spec_from_file_location(name, path, loader=SourceFileLoader(name, str(path)))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


reporter = load('report_oci_image', 'report-oci-image')
oci = load('oci_image')


class ReportTests(unittest.TestCase):
    def test_metadata_inspection_across_chunks_does_not_reassemble_files(self):
        with tempfile.TemporaryDirectory(prefix='image-report-test-') as tmp:
            root = Path(tmp)
            exports = root / 'export'
            exports.mkdir()
            with tarfile.open(exports / 'meta-test.tar', 'w') as archive:
                for name, data in {'metadata.yaml': b'architecture: x86_64\n',
                                   'templates/test.tpl': b'template'}.items():
                    member = tarfile.TarInfo(name)
                    member.size = len(data)
                    archive.addfile(member, io.BytesIO(data))
            (exports / 'disk.qcow2').write_bytes(b'QFI\xfb' + b'payload')
            layout = oci.convert_lxd(root / 'oci', 'amd64', export_directory=exports, vm=True, limit=257)
            before = {path: path.stat().st_mtime_ns for path in layout.rglob('*')}
            output = io.StringIO()
            with patch.object(reporter, 'disk_view', side_effect=RuntimeError('No VM tools in unit test')), \
                    contextlib.redirect_stdout(output):
                reporter.report(layout)
            self.assertIn('architecture: x86_64', output.getvalue())
            self.assertIn('templates/test.tpl', output.getvalue())
            self.assertIn('Filesystem capacity', output.getvalue())
            self.assertEqual(before, {path: path.stat().st_mtime_ns for path in layout.rglob('*')})
            self.assertFalse((layout / 'metadata.tar').exists())

    def test_runnable_image_reports_runtime_configuration(self):
        with tempfile.TemporaryDirectory() as tmp:
            with oci.Layout(Path(tmp) / 'oci') as layout:
                layout.finish(oci.container_config('arm64', [], {'User': '123:456'}), [])
            output = io.StringIO()
            with contextlib.redirect_stdout(output):
                reporter.report(layout.directory)
            self.assertIn('Runtime configuration', output.getvalue())
            self.assertIn('123:456', output.getvalue())
            self.assertIn('linux/arm64', output.getvalue())


if __name__ == '__main__':
    unittest.main()
