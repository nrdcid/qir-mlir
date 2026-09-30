# Conversion API boundary — M1

Expose call raising and bridge lowering separately. Use exact registry mappings,
explicit MLIR legality, and type conversion. Raising preserves CFG and instruction
order. Lowering must eliminate all bridge types/operations and unresolved casts.
Optional structured lifting does not belong in the default import pipeline.
