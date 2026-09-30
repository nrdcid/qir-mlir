add_llvm_executable(qir-mlir-opt qir-mlir-opt.cpp)
llvm_update_compile_flags(qir-mlir-opt)
target_link_libraries(qir-mlir-opt PRIVATE
  QIRBridgeIR MLIROptLib MLIRLLVMDialect MLIRTransforms)
