"""Behavioral checks for the deliberately incomplete command-line scaffold."""

import argparse
from pathlib import Path
import subprocess
import tempfile
import unittest


class CommandTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tool = BIN_DIR / "qir-mlir"
        if not cls.tool.is_file():
            raise AssertionError(f"missing scaffold executable: {cls.tool}")

    def run_tool(self, *args):
        return subprocess.run(
            [str(self.tool), *map(str, args)], capture_output=True, text=True
        )

    def test_help_lists_public_commands(self):
        result = self.run_tool("--help")
        self.assertEqual(result.returncode, 0, result.stderr)
        for command in ("import", "inspect", "export", "check"):
            self.assertIn(command, result.stdout)
        self.assertNotIn("--aarch64-neon-syntax", result.stdout)

    def test_import_help_lists_bridge_options(self):
        result = self.run_tool("import", "--help")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--mode", result.stdout)
        self.assertIn("strict", result.stdout)
        self.assertNotIn("--aarch64-neon-syntax", result.stdout)

    def test_version_identifies_scaffold(self):
        result = self.run_tool("--version")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("scaffold", result.stdout)

    def test_unimplemented_commands_preserve_destination(self):
        for command in ("import", "inspect", "export", "check"):
            with self.subTest(command=command), tempfile.TemporaryDirectory() as tmp:
                source = Path(tmp) / "input.ll"
                source.write_text("; scaffold input\n")
                output = Path(tmp) / "output"
                args = [command, source]
                if command != "check":
                    args += ["-o", output]
                result = self.run_tool(*args)
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("QIRB-E001 not-implemented", result.stderr)
                self.assertEqual(result.stdout, "")
                self.assertFalse(output.exists())
                output.write_bytes(b"existing output\x00\n")
                result = self.run_tool(*args)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(output.read_bytes(), b"existing output\x00\n")

    def test_invalid_invocations_fail(self):
        for args in ([], ["unknown"], ["import"],
                     ["import", "input.ll", "--mode=typo"],
                     ["inspect", "input.mlir", "--format=typo"],
                     ["check", "input.ll", "--contract=typo"]):
            with self.subTest(args=args):
                result = self.run_tool(*args)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--bin-dir", required=True, type=Path)
    options, remaining = parser.parse_known_args()
    BIN_DIR = options.bin_dir.resolve()
    unittest.main(argv=[__file__, *remaining])
