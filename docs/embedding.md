# Embedding status

The only implemented library target is `QIRBridgeIR`. The component API is
experimental and no installed CMake package is provided yet.

Within a build that adds this project with `add_subdirectory`, link
`QIRBridgeIR`, include `QIRBridge/IR/QIRBridgeDialect.h`, and register
`qirb::QIRBridgeDialect` alongside `mlir::LLVM::LLVMDialect` in the consumer's
`mlir::DialectRegistry`. The working example is
`tools/qir-mlir-opt/qir-mlir-opt.cpp`.

Consumers can parse and verify the scaffold dialect. They cannot yet import or
export QIR through it. Import, export, reporting, conversion, and optional
transformation libraries will be added separately as their tests land. Preserve
that separation so embedding import/export never enables optimizations implicitly.
