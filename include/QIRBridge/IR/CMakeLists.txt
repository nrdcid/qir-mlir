set(LLVM_TARGET_DEFINITIONS QIRBridgeDialect.td)
mlir_tablegen(QIRBridgeDialect.h.inc -gen-dialect-decls -dialect=qirb)
mlir_tablegen(QIRBridgeDialect.cpp.inc -gen-dialect-defs -dialect=qirb)
add_public_tablegen_target(QIRBridgeDialectIncGen)

set(LLVM_TARGET_DEFINITIONS QIRBridgeTypes.td)
mlir_tablegen(QIRBridgeTypes.h.inc -gen-typedef-decls -typedefs-dialect=qirb)
mlir_tablegen(QIRBridgeTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=qirb)
add_public_tablegen_target(QIRBridgeTypesIncGen)

set(LLVM_TARGET_DEFINITIONS QIRBridgeOps.td)
mlir_tablegen(QIRBridgeOps.h.inc -gen-op-decls)
mlir_tablegen(QIRBridgeOps.cpp.inc -gen-op-defs)
add_public_tablegen_target(QIRBridgeOpsIncGen)
