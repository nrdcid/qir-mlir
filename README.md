# qir-mlir

A C++/MLIR scaffold for importing a documented QIR 2.0 subset, lifting quantum
calls into the `qirb` dialect, and lowering them back to QIR.

**Status: scaffold, not v0.1.** The dialect and MLIR driver work. QIR import,
export, inspection, and subset validation are command shells that fail with
`QIRB-E001`; they do not write output. No QIR round-trip or producer compatibility
is claimed.

## Build and test

Use the matching LLVM/MLIR **21.1.8** development packages and tools recorded in
[toolchain.lock.json](toolchain.lock.json). CMake 3.24+, Ninja, a C++17 compiler,
Python 3, lit, FileCheck, llvm-as, and opt are required. Python runs tests only.
For a source-built toolchain, see [the build guide](docs/building.md).

```bash
cmake --preset dev \
  -DLLVM_DIR=/path/to/llvm/lib/cmake/llvm \
  -DMLIR_DIR=/path/to/llvm/lib/cmake/mlir
cmake --build --preset dev -j 2
ctest --preset dev
```

`cmake --build build --target check-qirb` builds both tools and runs all tests.
No dependencies are downloaded by CMake.

## Try the scaffold

```bash
build/bin/qir-mlir --help
build/bin/qir-mlir-opt test/IR/bell.mlir -o build/bell.mlir
build/bin/qir-mlir-opt test/Effects/conservative.mlir --cse --canonicalize
```

The MLIR Bell example tests dialect serialization; it is not generated from QIR.
The complete hand-authored QIR candidate is [test/Inputs/bell.ll](test/Inputs/bell.ll).
Its LLVM syntax is tested, but its bridge round trip is future work.

The following interface is reserved and currently returns a nonzero status:

```bash
build/bin/qir-mlir import test/Inputs/bell.ll --mode=strict -o build/imported.mlir
build/bin/qir-mlir inspect build/imported.mlir --format=json -o build/report.json
build/bin/qir-mlir export build/imported.mlir -o build/roundtrip.ll
build/bin/qir-mlir check build/roundtrip.ll --contract=base-subset
```

## Project map

| Path | Purpose |
| --- | --- |
| `include/QIRBridge/IR`, `lib/IR` | TableGen reference types, operations, verifiers |
| `include/QIRBridge/{Import,Export,Analysis,Conversion}` | Reserved library boundaries |
| `lib/{Import,Export,Analysis,Conversion,Transforms}` | Milestone implementation notes |
| `tools/` | `qir-mlir` command shell and working `qir-mlir-opt` driver |
| `test/` | lit/FileCheck, CLI tests, candidate QIR fixtures, planned harnesses |
| `integration/producers/`, `benchmarks/` | Producer and benchmark requirements |
| `docs/` | Design, contracts, support/preservation matrices, milestone gates |

Start with [M0 in the roadmap](docs/roadmap.md). The upstream LLVM import/export
preservation spike must pass before implementing semantic lifting.
