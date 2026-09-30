// RUN: %qir-mlir-opt %s --cse --canonicalize | FileCheck %s
module {
  llvm.func @effects() {
    %q = "qirb.static_qubit"() {id = 0 : i64} : () -> !qirb.qubit_ref
    %r = "qirb.static_result"() {id = 0 : i64} : () -> !qirb.result_ref
    "qirb.h"(%q) : (!qirb.qubit_ref) -> ()
    "qirb.h"(%q) : (!qirb.qubit_ref) -> ()
    llvm.call @unknown() : () -> ()
    "qirb.mz"(%q, %r) : (!qirb.qubit_ref, !qirb.result_ref) -> ()
    "qirb.mz"(%q, %r) : (!qirb.qubit_ref, !qirb.result_ref) -> ()
    llvm.return
  }
  llvm.func @unknown()
}
// CHECK-LABEL: llvm.func @effects
// CHECK: "qirb.h"
// CHECK-NEXT: "qirb.h"
// CHECK-NEXT: llvm.call @unknown
// CHECK-NEXT: "qirb.mz"
// CHECK-NEXT: "qirb.mz"
// CHECK-NEXT: llvm.return
