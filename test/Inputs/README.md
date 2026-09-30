# Fixture provenance

These are hand-authored scaffold fixtures guided by the Base Profile at
[`f5647346542d5a65225c3eb349847fe4df01d1b2`](https://github.com/qir-alliance/qir-spec/blob/f5647346542d5a65225c3eb349847fe4df01d1b2/specification/profiles/Base_Profile.md).
They are not frozen output from a producer and do not establish compatibility.

| Fixture | Purpose |
| --- | --- |
| `bell.ll` | Complete four-block Bell candidate with initialization, attributes, flags, and labeled tuple output |
| `zero-handles.ll` | Same null encoding in initialization, qubit, and result positions |
| `sparse-resources.ll` | Qubit ID 7/result ID 3 with capacities 8/4 and one observed resource of each kind |

The fixtures deliberately omit target triple and data layout. That absence must
survive future round trips; execution tests will use a separately validated host
contract. The current suite establishes only LLVM parse/verifier success.
