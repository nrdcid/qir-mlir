# Verification strategy

## Running existing tests

```bash
cmake --build build --target check-qirb
```

`test/IR` covers textual MLIR serialization and operation types.
`test/Negative` covers local verifier failures.
`test/Effects` checks that CSE/canonicalization retain ordered stateful operations.
`test/Profiles/fixture-syntax.test` assembles and verifies all three candidate QIR
fixtures with LLVM; it does not validate QIR profiles.
`test/CLI/commands.py` checks command discovery, usage errors, explicit unavailable
behavior, and untouched/missing output files on failure.

## Required future layers

| Layer | Evidence required |
| --- | --- |
| Local verification | Types, operation invariants, resource boundaries |
| Import/export tests | lit/FileCheck mappings and precise rejection paths |
| Structural preservation | Contracts, calls/operands, labels, CFG semantics; normalize only irrelevant naming |
| ABI traces | Original versus exported execution with scripted measurement outcomes |
| Independent quantum semantics | Small exact probabilities/post-measurement states or full unitary comparison |
| Producer integration | Original versioned output and repeatable generation |

Prioritize zero handles versus initialization null; sparse IDs/capacity bounds;
wrong signatures and unexpected QIS definitions; label nesting/order; conflicting
flags/ABI; PHI incoming-edge identity; repeated slot writes/reads; unknown calls
between gates; malformed bitcode; unresolved casts; and unhandled metadata/bundles.

For acyclic adaptive fixtures enumerate short scripted outcomes and compare every
feasible path. ABI traces establish preserved calls, not quantum equivalence.
Rewrite traces intentionally differ, so use an independent small-circuit oracle.
Start numerical unitary checks at a documented `1e-10` double-precision threshold
and explicitly define global-phase observability. Sampling histograms are only
smoke tests. Never implement the oracle by reusing the bridge's gate registry.
