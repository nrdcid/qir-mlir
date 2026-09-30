# Building the scaffold

The required candidate is LLVM/MLIR 21.1.8, C++17, RTTI on, assertions off.
Both LLVM and MLIR must come from the same build. The lock records the upstream
commit and the local distribution package revision separately; distro patches
are not claimed to be identical to an unpatched upstream build.

## From an existing toolchain

```bash
cmake --preset dev \
  -DLLVM_DIR=/path/to/prefix/lib/cmake/llvm \
  -DMLIR_DIR=/path/to/prefix/lib/cmake/mlir
cmake --build --preset dev -j 2
ctest --preset dev
```

To supply lit explicitly, add `-DQIRB_LIT=/path/to/llvm-lit`. LLVM source builds
place that script in their `bin` directory. Distribution packages may name it
`lit` or `lit-21`. CMake rejects a mismatched LLVM release, RTTI, or assertions
configuration. Use an out-of-tree build; keep local paths in CMake's build cache
or an ignored `CMakeUserPresets.json`.

## Building the locked source revision

This is an explicit dependency build, not something project configuration does
automatically. Run it outside this repository:

```bash
git clone https://github.com/llvm/llvm-project.git
git -C llvm-project checkout 2078da43e25a4623cab2d0d60decddf709aaea28
cmake -S llvm-project/llvm -B llvm-build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS=mlir \
  -DLLVM_TARGETS_TO_BUILD=Native \
  -DLLVM_ENABLE_RTTI=ON \
  -DLLVM_ENABLE_ASSERTIONS=OFF \
  -DLLVM_INCLUDE_TESTS=ON \
  -DMLIR_INCLUDE_TESTS=ON
cmake --build llvm-build -j 2
```

Then set `LLVM_DIR` to `llvm-build/lib/cmake/llvm` and `MLIR_DIR` to
`llvm-build/lib/cmake/mlir`. The full build can require substantial time and disk
space. The CI workflow uses this source revision and caches its build.

## Local verification environment

During scaffolding, LLVM was already installed. Matching Ubuntu MLIR packages
were downloaded and extracted without system installation under
`/tmp/qir-mlir-deps/root`. The local build cache references that temporary path.
Reconfigure with your durable toolchain paths if `/tmp` is cleared.

Tests cover dialect parsing/verification, MLIR text serialization, conservative
effects under CSE/canonicalization, CLI failures without output damage, and LLVM
verification of candidate fixtures. No execution runtime is needed yet.
