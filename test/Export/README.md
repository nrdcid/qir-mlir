# Export regression tests — M1

Cover exact symbols/signatures, static constant reconstruction, declaration reuse
and conflicts, metadata restoration, and rejection of unresolved casts or bridge
types. A failed export must neither create a partial output nor overwrite an
existing destination. Test standalone MLIR input after process restart.
