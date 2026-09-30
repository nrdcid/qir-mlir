import os
import shlex

import lit.formats

config.name = "QIRBridge"
config.test_format = lit.formats.ShTest(execute_external=True)
config.suffixes = [".mlir", ".test"]
config.excludes = ["Inputs", "runtime"]
config.test_source_root = os.path.join(config.qirb_source_root, "test")
config.test_exec_root = config.qirb_test_root
config.substitutions.extend([
    ("%qir-mlir-opt", shlex.quote(os.path.join(config.qirb_tools_dir, "qir-mlir-opt"))),
    ("FileCheck", shlex.quote(config.qirb_filecheck)),
    ("%llvm-as", shlex.quote(config.qirb_llvm_as)),
    ("%opt", shlex.quote(config.qirb_opt)),
])
