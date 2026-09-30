# Benchmark plan — M5

Measure three separate pipelines: upstream import/export; quantum raising/lowering;
and optional transformation. Record stage wall times, peak RSS, output size,
acceptance denominator, quantum coverage/unknown candidates, and preservation
failures by category.

Start with Bell/GHZ, rotations, output shapes, and feed-forward fixtures. Generate
100/1,000/10,000-operation size sweeps; keep quantum simulation sizes independently
small. Record machine, exact toolchain/corpus, warm/cold conditions, repetitions,
median, and p95. No performance claims or synthetic success benchmarks exist yet.
