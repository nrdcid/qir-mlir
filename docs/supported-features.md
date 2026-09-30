# Supported-feature matrix

“Scaffold tested” means local dialect/driver behavior only. No row implies QIR
import, profile conformance, execution, or frontend compatibility.

| Capability | Status | Acceptance target |
| --- | --- | --- |
| Out-of-tree build and CLI command discovery | Scaffold tested | M0 |
| Reference types and static handle constructors | Scaffold tested; local invariants only | M1 |
| H/CNOT/mz dialect operations | Scaffold tested; no ABI mapping yet | M1 |
| Static result-to-pointer boundary | Scaffold tested; no lowering yet | M1 |
| Conservative CSE/canonicalization behavior | Scaffold regression tested | M1–M2 |
| Candidate Bell/zero/sparse `.ll` syntax | LLVM verification only | M0 |
| `.ll`/`.bc` import and strict preflight | Not implemented | M0–M1 |
| Metadata and ABI preservation | Not implemented | M0–M1 |
| Static ID resolver and QIS registry | Not implemented | M1 |
| Standalone export and round-trip comparison | Not implemented | M1 |
| Resource/coverage JSON report | Not implemented | M1 |
| Runtime trace shim and semantic oracle | Not implemented | M1 |
| Mixed mode | Reserved; unavailable | After strict mode |
| Additional gates/rotations and adjacent-H rewrite | Not implemented | M2 |
| Result reads and Adaptive CFG | Not implemented | M3 |
| PyQIR, Q#, CUDA-Q integration | No versions tested | M4 |
| Packaging and stable embedding API | Not implemented | M5 |

Every new accepted feature must land with import, verification, export, positive
and negative cases, and preservation checks. A declaration in TableGen alone
never adds a QIR compatibility claim.
