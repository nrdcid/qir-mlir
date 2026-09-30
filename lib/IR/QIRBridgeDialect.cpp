#include "QIRBridge/IR/QIRBridgeDialect.h"
#include "QIRBridge/IR/QIRBridgeOps.h"
#include "QIRBridge/IR/QIRBridgeTypes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "llvm/ADT/TypeSwitch.h"

#include "QIRBridge/IR/QIRBridgeDialect.cpp.inc"

#define GET_TYPEDEF_CLASSES
#include "QIRBridge/IR/QIRBridgeTypes.cpp.inc"

void qirb::QIRBridgeDialect::initialize() {
  addTypes<
#define GET_TYPEDEF_LIST
#include "QIRBridge/IR/QIRBridgeTypes.cpp.inc"
      >();
  addOperations<
#define GET_OP_LIST
#include "QIRBridge/IR/QIRBridgeOps.cpp.inc"
      >();
}
