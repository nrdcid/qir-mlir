#include "QIRBridge/IR/QIRBridgeDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/Transforms/Passes.h"

int main(int argc, char **argv) {
  mlir::DialectRegistry registry;
  registry.insert<qirb::QIRBridgeDialect, mlir::LLVM::LLVMDialect>();
  // Available for explicit guardrail testing only; no passes run by default.
  mlir::registerTransformsPasses();
  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "QIR bridge dialect driver\n", registry));
}
