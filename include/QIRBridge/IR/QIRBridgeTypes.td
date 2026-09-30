#ifndef QIRBRIDGE_TYPES
#define QIRBRIDGE_TYPES

include "QIRBridge/IR/QIRBridgeDialect.td"
include "mlir/IR/AttrTypeBase.td"

def QIRBridge_QubitRef : TypeDef<QIRBridge_Dialect, "QubitRef"> {
  let mnemonic = "qubit_ref";
  let summary = "Handle to mutable qubit state, not a quantum SSA state";
  let assemblyFormat = "";
}

def QIRBridge_ResultRef : TypeDef<QIRBridge_Dialect, "ResultRef"> {
  let mnemonic = "result_ref";
  let summary = "Handle to a mutable measurement result slot";
  let assemblyFormat = "";
}

#endif
