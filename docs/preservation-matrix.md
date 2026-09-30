# M0 preservation inventory

All upstream round-trip observations are **pending**. These are required audit
rows, not assertions that LLVM import/export already preserves the properties.

| Property | Intended policy | Required experiment |
| --- | --- | --- |
| Triple/layout, including absence | Preserve exactly | Explicit and omitted values |
| Module flags | Structured symmetric attributes | Values, LLVM types, merge behaviors, conflicts |
| Entry/profile/count attributes | Original spelling plus validated interpretation | Disk serialization and standalone export |
| Function/call ABI | Preserve supported fields; reject the rest | Linkage, visibility, conventions, parameter/call attributes |
| Labels/globals | Preserve bytes, length, references | Embedded bytes, unique labels, output order |
| QIS and runtime calls | Exact registered mapping | Operand order, constants, modifiers, boundaries |
| Static handle forms | Reconstruct audited encodings | Null roles, sparse IDs, capacity edges |
| CFG/PHIs | Preserve edge/value association | Branch polarity and merges in M3 |
| Integer/floating flags | Preserve or reject | Flags that cannot map faithfully |
| Debug and other metadata | Preserve or explicitly reject | Debug-only loss policy and semantic attachments |
| Aliases, bundles, unsupported LLVM instructions | Reject in preflight | Precise diagnostics before translation |

Capture both baseline LLVM-dialect import/export artifacts and their inventory
before enabling quantum lifting. Use the same three fixture inputs to isolate
upstream translation gaps from bridge bugs. Record any bounded extension in an
ADR and replace “pending” with observed evidence and the exact toolchain.
