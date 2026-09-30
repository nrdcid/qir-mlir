#ifndef QIRBRIDGE_OPS
#define QIRBRIDGE_OPS

include "QIRBridge/IR/QIRBridgeTypes.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

class QIRBridge_Op<string mnemonic, list<Trait> traits = []>
    : Op<QIRBridge_Dialect, mnemonic, traits>;

def QIRBridge_StaticQubitOp : QIRBridge_Op<"static_qubit", [Pure]> {
  let summary = "Construct a function-scoped static qubit handle";
  let arguments = (ins I64Attr:$id);
  let results = (outs QIRBridge_QubitRef:$result);
  let hasVerifier = 1;
}

def QIRBridge_StaticResultOp : QIRBridge_Op<"static_result", [Pure]> {
  let summary = "Construct a function-scoped static result-slot handle";
  let arguments = (ins I64Attr:$id);
  let results = (outs QIRBridge_ResultRef:$result);
  let hasVerifier = 1;
}

// Use the default resource so effects conservatively alias unraised LLVM calls.
// These operations deliberately have no speculation trait.
def QIRBridge_HOp : QIRBridge_Op<"h", [MemoryEffects<[MemRead, MemWrite]>]> {
  let summary = "Apply the registered Hadamard instruction";
  let arguments = (ins QIRBridge_QubitRef:$qubit);
}

def QIRBridge_CnotOp :
    QIRBridge_Op<"cnot", [MemoryEffects<[MemRead, MemWrite]>]> {
  let summary = "Apply CNOT with ordered control and target operands";
  let arguments = (ins QIRBridge_QubitRef:$control, QIRBridge_QubitRef:$target);
}

def QIRBridge_MzOp : QIRBridge_Op<"mz", [MemoryEffects<[MemRead, MemWrite]>]> {
  let summary = "Measure a qubit into an existing result slot";
  let arguments = (ins QIRBridge_QubitRef:$qubit, QIRBridge_ResultRef:$slot);
  // Reading a slot will be a separate effectful operation in M3.
}

def QIRBridge_ResultToPtrOp : QIRBridge_Op<"result_to_ptr", [Pure]> {
  let summary = "Expose a verified static result handle to an LLVM call";
  let arguments = (ins QIRBridge_ResultRef:$slot);
  let results = (outs LLVM_AnyPointer:$result);
  let hasVerifier = 1;
}

#endif
