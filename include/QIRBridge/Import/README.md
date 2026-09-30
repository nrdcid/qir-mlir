# Import API boundary — M0/M1

Add public preflight, QIS registry, and import APIs only with their implementations
and tests. Inputs will be `.ll`/`.bc` plus explicit strict-mode options. Results
must carry a verified MLIR module and serialized preservation contract, or a
categorized error. Never silently substitute an ABI or classify every pointer as
a resource. The interface is not frozen by this scaffold.
