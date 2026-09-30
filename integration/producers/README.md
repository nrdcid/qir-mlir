# Producer integration — M4

Evaluate PyQIR and one of Q#/CUDA-Q by inspecting actual emitted IR. Record exact
versions, output mode, dependencies, generation command, and target assumptions
before claiming QIR 2 compatibility.

For each selected producer add `manifest.json`, a regeneration script, and an
`original/` directory containing unmodified output. Put adapters in separately
tested code; do not edit originals silently. Update the lock and compatibility
table only after end-to-end results exist.

| Producer | Version | Compatibility |
| --- | --- | --- |
| PyQIR | Unselected | Untested |
| Q# or CUDA-Q | Unselected | Untested |
