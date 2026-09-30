add_mlir_dialect_library(QIRBridgeIR
  QIRBridgeDialect.cpp
  QIRBridgeOps.cpp

  DEPENDS
  QIRBridgeDialectIncGen
  QIRBridgeTypesIncGen
  QIRBridgeOpsIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRLLVMDialect
  MLIRSideEffectInterfaces
)

target_compile_features(QIRBridgeIR PUBLIC cxx_std_17)
target_include_directories(QIRBridgeIR PUBLIC
  "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
  "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>"
)
target_include_directories(QIRBridgeIR SYSTEM PUBLIC
  ${LLVM_INCLUDE_DIRS} ${MLIR_INCLUDE_DIRS}
)
