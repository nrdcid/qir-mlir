# Import regression tests — M0/M1

Use complete fixtures under `../Inputs/`. Add lit/FileCheck cases for strict
preflight, exact mappings, contextual zero handles, wide-ID bounds, ABI attributes,
metadata, labels, and rejected features. `.bc` fixtures should be generated with
the pinned llvm-as during testing, not committed as opaque artifacts.
