# ADR 0001: explicit scaffold and candidate dependency pins

Date: 2026-09-29. Status: accepted for scaffolding; M0 feasibility pending.

Use upstream LLVM/MLIR 21.1.8 as the first candidate because matching LLVM tools
are available locally. Record its exact commit and the inspected QIR specification
commit in `toolchain.lock.json`. Keep runtime, producer versions, execution target,
and data layout unset until actual integration tests establish them.

Build a real, minimal TableGen dialect and an MLIR driver. Keep QIR commands
explicitly unavailable until the preservation pipeline exists. Do not add fake
success paths, full-module replay, empty public libraries, speculative adapters,
or a prototype parser that competes with LLVM's parser.

The scaffold supports typed handle construction, H/CNOT/mz, and a static result
pointer boundary. This does not waive the plan's requirement to prove an unraised
LLVM-dialect round trip before implementing semantic call lifting.

M0 must validate or revise the candidate pins, complete the preservation matrix,
and document bounded extensions or rejections. Build success alone cannot close
that milestone.
