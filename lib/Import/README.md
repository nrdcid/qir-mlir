# Import implementation — M0/M1

Implement `QIRPreflight`, `LLVMImporter`, and `QISRegistry` here. Start with an
unraised LLVM-dialect baseline and the preservation inventory. Add exact H/CNOT/mz
registration only after preflight can reject unsupported features before loss.
Known symbols with bad signatures or unexpected definitions must fail explicitly.
