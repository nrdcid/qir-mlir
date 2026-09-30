# Implementation milestones

The scaffold is preparation for M0. None of these exit gates is complete.
Calendar estimates assume one developer; acceptance gates govern release claims.

| Milestone | Work | Binding exit gate |
| --- | --- | --- |
| M0 / week 1 | Confirm candidate pins; upstream baseline; metadata/ABI inventory; preflight design | Complete fixture has every preservation property accounted for or explicitly rejected |
| M1 / weeks 2–4 | Registry/resolver, strict import/export, pointer boundaries, reporting, exact-ABI trace shim | Serialized Bell round trip verifies and preserves calls, labels, output order, and distinct zero handles; tag v0.1 |
| M2 / weeks 5–7 | Register additional gates individually; output nesting; diagnostics; adjacent-H rewrite; circuit generation | Every accepted feature preserves its contract; negative injections and effect/rewrite mutations are caught |
| M3 / weeks 8–10 | Current result-read ABI, booleans, acyclic branches, integer ops, PHIs, result-slot definitions | Exhaustive scripted outcomes preserve feasible path behavior, polarity, and edge values |
| M4 / weeks 11–13 | Inspect/pin PyQIR and one of Q#/CUDA-Q; keep original output; explicit adapters | Two producer workloads pass, or compatibility claims explicitly narrow with blocking evidence |
| M5 / weeks 14–16 | Embedding API, packaging, benchmarks, technical report | Clean checkout and required CI pass; all claimed features have positive/negative preservation tests; tag v0.2 |

## First ten working days

1. Days 1–2: reproduce the locked build and confirm target assumptions.
2. Days 3–4: run unmodified upstream import/export on the complete Base fixture;
   inventory every attribute, flag, and encoding gap.
3. Day 5: implement preflight and bounded preservation extensions, with failing
   rejection tests first.
4. Days 6–7: validate the scaffold dialect against the contract and effect policy.
5. Day 8: implement exact call recognition and operand-context resource decoding.
6. Day 9: implement lowering and standalone serialized round trips.
7. Day 10: compare Bell ABI traces and zero-handle roles; document the remaining
   M1 gate failures.

Resolve fundamental upstream gaps before expanding the dialect. Do not write a
general LLVM importer as a workaround.

## First report and rewrite

Report per entry point: declared capacities, distinct IDs/highest ID, static gate,
measurement/read/output counts, unknown calls/reasons, and profile checks marked
passed/failed/not checked. Add measurement-dependent branches once available.
Never present static counts as dynamic execution counts.

Only after this works, cancel immediately adjacent registered H operations on the
same static qubit in one block. Require no intervening operation; define metadata
handling; validate the changed program with an independent semantic oracle.

## Optional months five and six

Choose one: selected structured control-flow lifting, dynamic-lifetime analysis,
a downstream consumer adapter, or broader profile checks. Select from consumer
evidence after v0.1, and complete its prerequisite preservation work first.
