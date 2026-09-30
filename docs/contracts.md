# Planned import/export contract

**No input is accepted by the scaffold's QIR commands yet.** `base-subset` and
`adaptive-subset` are project contract names; never emit them as QIR profile
attributes. Preserve the validated specification spelling, such as `base_profile`.

Strict mode is the default. Unknown quantum/runtime calls, unsupported resource
uses, absent required data, or unpreservable fields must fail. Mixed mode is
reserved until strict preservation works; it must still reject upstream
translation gaps and report partial coverage. Unknown calls block semantic
conclusions and crossing transformations without an explicit effect contract.

## Required preservation

Preserve target triple and data layout exactly, including absence. Preserve module
flag values, types, and merge behaviors; function/profile attributes and their
original spelling; declared counts separately from observed resource use; ABI
signatures, linkage, visibility, conventions, and supported attributes; output
label bytes, lengths, references, nesting, and event order; exact quantum operands
and parameter bits; and CFG/classical instruction semantics.

Serialize versioned preservation attributes into MLIR. Avoid raw-operation-address
side tables and replay of the entire original module. Reject unhandled metadata,
bundles, aliases, or instruction features before upstream import can lose them.
Any permitted debug-only loss needs an explicit mode and diagnostic.

Import must parse and verify LLVM, inventory the contract before simplification,
preflight the envelope, import upstream, attach preservation data by unambiguous
mappings, verify MLIR/bridge invariants, and raise eligible calls in place.

Export must verify the contract, lower types/ops with explicit conversion legality,
reuse only compatible declarations, reject surviving bridge ops/types or
`unrealized_conversion_cast`, export LLVM, restore audited metadata, then run LLVM
and subset checks. Reconstruct required constant encodings narrowly. Write the
final output atomically after all checks succeed.

## Explicitly deferred

Dynamic allocation, resource arrays in memory, arbitrary pointer aliasing,
resource-bearing loads/stores, indirect calls, exceptions, inline assembly,
recursion, helper-function analysis, loop reconstruction, scheduling, and automatic
profile legalization are unsupported. Array *output markers* are serialization
events and do not establish resource-array support.

## Diagnostics

| Category | Meaning |
| --- | --- |
| Invalid LLVM | LLVM parse or verifier failure |
| Invalid QIR under implemented checks | An implemented subset requirement failed |
| Unsupported input | A valid construct lies outside the tested envelope |
| Preservation failure | Required properties changed or cannot be represented |
| Internal error | A bridge invariant failed unexpectedly |

The scaffold reserves `QIRB-E001 not-implemented` and `QIRB-E002 invalid-command`.
LLVM's option parser also reports usage errors. Future semantic diagnostics need
stable codes, function/block/instruction context, symbol/operand details, and an
action. Dialect verifier messages currently use standard MLIR locations; they are
not yet the stable QIR diagnostic interface.
