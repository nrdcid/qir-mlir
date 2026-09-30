#ifndef QIRBRIDGE_DIALECT
#define QIRBRIDGE_DIALECT

include "mlir/IR/OpBase.td"

def QIRBridge_Dialect : Dialect {
  let name = "qirb";
  let cppNamespace = "::qirb";
  let summary = "Typed resource handles and quantum bridge operations";
  let useDefaultTypePrinterParser = 1;
}

#endif
