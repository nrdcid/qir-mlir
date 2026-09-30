// RUN: %qir-mlir-opt %s | %qir-mlir-opt | FileCheck %s
// This is a dialect fixture, not imported QIR or a complete preservation contract.
module {
  llvm.func @bell() -> i64 {
    %q0 = "qirb.static_qubit"() {id = 0 : i64} : () -> !qirb.qubit_ref
    %q1 = "qirb.static_qubit"() {id = 1 : i64} : () -> !qirb.qubit_ref
    %r0 = "qirb.static_result"() {id = 0 : i64} : () -> !qirb.result_ref
    %r1 = "qirb.static_result"() {id = 1 : i64} : () -> !qirb.result_ref
    "qirb.h"(%q0) : (!qirb.qubit_ref) -> ()
    "qirb.cnot"(%q0, %q1) : (!qirb.qubit_ref, !qirb.qubit_ref) -> ()
    "qirb.mz"(%q0, %r0) : (!qirb.qubit_ref, !qirb.result_ref) -> ()
    "qirb.mz"(%q1, %r1) : (!qirb.qubit_ref, !qirb.result_ref) -> ()
    %ptr = "qirb.result_to_ptr"(%r0) : (!qirb.result_ref) -> !llvm.ptr
    llvm.call @record(%ptr) : (!llvm.ptr) -> ()
    %zero = llvm.mlir.constant(0 : i64) : i64
    llvm.return %zero : i64
  }
  llvm.func @record(!llvm.ptr)
}
// CHECK: "qirb.static_qubit"() {{.*}}id = 0 : i64
// CHECK: "qirb.static_qubit"() {{.*}}id = 1 : i64
// CHECK: "qirb.static_result"() {{.*}}id = 0 : i64
// CHECK: "qirb.static_result"() {{.*}}id = 1 : i64
// CHECK: "qirb.h"
// CHECK: "qirb.cnot"
// CHECK: "qirb.mz"
// CHECK: "qirb.mz"
// CHECK: "qirb.result_to_ptr"
// CHECK: llvm.call @record
