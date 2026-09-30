# Design boundary

The product is a reusable semantic boundary for a tested QIR subset. Reverse
lowering is its preservation harness. Scheduling, routing, a new frontend,
general optimization, and arbitrary LLVM recovery are outside the first release.

```mermaid
flowchart LR
  A[LLVM parse and preflight] --> B[LLVM dialect plus preserved contract]
  B --> C[Exact QIS recognition and static resource resolution]
  C --> D[Mixed qirb and LLVM IR]
  D --> E[Verify and report]
  E --> F[Lower qirb and export LLVM]
  F --> G[Preservation and behavioral checks]
```

## Component ownership

| Component | Responsibility and boundary |
| --- | --- |
| QIRPreflight | Verify LLVM and inventory versions, ABI, metadata, and the accepted feature envelope before import |
| LLVMImporter | Use upstream import and associate preservation data with stable symbols |
| QISRegistry | Match exact symbol, signature, version, attributes, calling convention, and operand roles |
| StaticResourceResolver | Decode an operand in its expected qubit/result role, never from pointer type alone |
| RaiseQIRCalls | Replace recognized calls in place without changing order or CFG |
| BridgeVerifier | Check implemented type, resource, contract, and output invariants |
| LowerQIRBridge | Perform explicit dialect/type conversion to the selected original ABI |
| QIRExporter | Export and restore only audited, still-valid metadata |
| PreservationChecker | Compare structure, contracts, traces, and independent semantics |

Only the dialect library exists in this scaffold. Do not publish placeholder
component APIs as stable contracts.

## Resource and effect contract

`!qirb.qubit_ref` and `!qirb.result_ref` are reusable handles. Identity is scoped
by function, resource kind, and ID. The scaffold's constructors accept
nonnegative signed `i64` IDs within `llvm.func`; a future QIR resolver must check
the original wide integer before narrowing and check declared resource capacity.
Full unsigned 64-bit ID support is not established by this scaffold.

`qirb.mz` has a qubit operand, a result-slot operand, and zero results. A later
`qirb.read_result` will read the slot's current value; result slots are not SSA
measurement values. Null initialization pointers are not quantum resources.

H, CNOT, and measurement have read/write effects on the default resource and no
speculation trait. Static constructors and the verified `result_to_ptr`
conversion are pure. The conversion currently requires a direct static result
constructor and an address-space-zero pointer. No general optimizer runs by
default, and the adjacent-H rewrite is not implemented.

## Control flow

Retain `llvm.func`, LLVM branches, and block arguments first. A later whole-function
conversion to `func`/`cf`/`arith` needs proven mappings for its ABI, integer widths,
flags, and poison behavior. Optional `scf.if` recovery starts with a single
eligible acyclic diamond. Loops and interprocedural analysis remain deferred.

The build and effect approach follows upstream guidance on
[out-of-tree dialects](https://mlir.llvm.org/docs/Tutorials/CreatingADialect/) and
[effects/speculation](https://mlir.llvm.org/docs/Rationale/SideEffectsAndSpeculation/).
