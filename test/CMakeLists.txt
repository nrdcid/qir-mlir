find_package(Python3 REQUIRED COMPONENTS Interpreter)
find_program(QIRB_LIT NAMES llvm-lit lit lit-21
  HINTS "${LLVM_TOOLS_BINARY_DIR}" REQUIRED)
find_program(QIRB_FILECHECK NAMES FileCheck FileCheck-21
  HINTS "${LLVM_TOOLS_BINARY_DIR}" REQUIRED)
find_program(QIRB_LLVM_AS NAMES llvm-as llvm-as-21
  HINTS "${LLVM_TOOLS_BINARY_DIR}" REQUIRED)
find_program(QIRB_OPT NAMES opt opt-21
  HINTS "${LLVM_TOOLS_BINARY_DIR}" REQUIRED)

configure_file(lit.site.cfg.py.in lit.site.cfg.py @ONLY)
add_test(NAME qirb-lit
  COMMAND "${Python3_EXECUTABLE}" "${QIRB_LIT}" -v "${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME qirb-cli
  COMMAND "${Python3_EXECUTABLE}" "${CMAKE_CURRENT_SOURCE_DIR}/CLI/commands.py"
    --bin-dir "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
add_custom_target(check-qirb
  COMMAND "${CMAKE_CTEST_COMMAND}" --output-on-failure
  WORKING_DIRECTORY "${PROJECT_BINARY_DIR}"
  DEPENDS qir-mlir qir-mlir-opt
  USES_TERMINAL)
