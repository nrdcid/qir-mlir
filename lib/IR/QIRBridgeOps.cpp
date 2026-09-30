#include "QIRBridge/IR/QIRBridgeOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/OpImplementation.h"

#define GET_OP_CLASSES
#include "QIRBridge/IR/QIRBridgeOps.cpp.inc"

static mlir::LogicalResult verifyStaticID(mlir::Operation *op,
                                        mlir::IntegerAttr id) {
  if (!op->getParentOfType<mlir::LLVM::LLVMFuncOp>())
    return op->emitOpError("requires an enclosing llvm.func resource scope");
  if (id.getValue().isNegative())
    return op->emitOpError("static resource ID must be non-negative");
  return mlir::success();
}

mlir::LogicalResult qirb::StaticQubitOp::verify() {
  return verifyStaticID(getOperation(), getIdAttr());
}

mlir::LogicalResult qirb::StaticResultOp::verify() {
  return verifyStaticID(getOperation(), getIdAttr());
}

mlir::LogicalResult qirb::ResultToPtrOp::verify() {
  if (!getSlot().getDefiningOp<StaticResultOp>())
    return emitOpError("requires a direct qirb.static_result origin");
  if (mlir::cast<mlir::LLVM::LLVMPointerType>(getResult().getType())
          .getAddressSpace() != 0)
    return emitOpError("requires an address-space-zero pointer");
  return mlir::success();
}
