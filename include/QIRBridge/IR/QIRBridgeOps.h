#ifndef QIRBRIDGE_IR_QIRBRIDGEOPS_H
#define QIRBRIDGE_IR_QIRBRIDGEOPS_H

#include "QIRBridge/IR/QIRBridgeDialect.h"
#include "QIRBridge/IR/QIRBridgeTypes.h"
#include "mlir/Bytecode/BytecodeOpInterface.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#define GET_OP_CLASSES
#include "QIRBridge/IR/QIRBridgeOps.h.inc"

#endif
