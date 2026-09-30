add_llvm_executable(qir-mlir qir-mlir.cpp)
llvm_update_compile_flags(qir-mlir)
llvm_map_components_to_libnames(qirb_cli_llvm_libs Support)
target_link_libraries(qir-mlir PRIVATE ${qirb_cli_llvm_libs})
