// RUN: %qir-mlir-opt %s --split-input-file --verify-diagnostics
module {
  llvm.func @negative_id() {
    // expected-error @+1 {{static resource ID must be non-negative}}
    %q = "qirb.static_qubit"() {id = -1 : i64} : () -> !qirb.qubit_ref
    llvm.return
  }
}
// -----
module {
  llvm.func @wrong_kind() {
    %r = "qirb.static_result"() {id = 0 : i64} : () -> !qirb.result_ref
    // expected-error @+1 {{operand #0 must be}}
    "qirb.h"(%r) : (!qirb.result_ref) -> ()
    llvm.return
  }
}
// -----
module {
  llvm.func @measurement_result() {
    %q = "qirb.static_qubit"() {id = 0 : i64} : () -> !qirb.qubit_ref
    %r = "qirb.static_result"() {id = 0 : i64} : () -> !qirb.result_ref
    // expected-error @+1 {{requires zero results}}
    %value = "qirb.mz"(%q, %r) : (!qirb.qubit_ref, !qirb.result_ref) -> i1
    llvm.return
  }
}
// -----
module {
  // expected-error @+1 {{requires an enclosing llvm.func resource scope}}
  %q = "qirb.static_qubit"() {id = 0 : i64} : () -> !qirb.qubit_ref
}
// -----
module {
  llvm.func @nonstatic_boundary() {
    %r = "builtin.unrealized_conversion_cast"() : () -> !qirb.result_ref
    // expected-error @+1 {{requires a direct qirb.static_result origin}}
    %p = "qirb.result_to_ptr"(%r) : (!qirb.result_ref) -> !llvm.ptr
    llvm.return
  }
}
