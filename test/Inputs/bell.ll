; Hand-authored QIR 2.0 Base candidate. LLVM syntax is tested; bridge import is not.
@pair_label = internal constant [5 x i8] c"pair\00"
@left_label = internal constant [5 x i8] c"left\00"
@right_label = internal constant [6 x i8] c"right\00"

define i64 @bell() #0 {
initialize:
  call void @__quantum__rt__initialize(ptr null)
  br label %unitary
unitary:
  call void @__quantum__qis__h__body(ptr null)
  call void @__quantum__qis__cnot__body(ptr null, ptr inttoptr (i64 1 to ptr))
  br label %measure
measure:
  call void @__quantum__qis__mz__body(ptr null, ptr writeonly null)
  call void @__quantum__qis__mz__body(ptr inttoptr (i64 1 to ptr), ptr writeonly inttoptr (i64 1 to ptr))
  br label %record
record:
  call void @__quantum__rt__tuple_record_output(i64 2, ptr @pair_label)
  call void @__quantum__rt__result_record_output(ptr null, ptr @left_label)
  call void @__quantum__rt__result_record_output(ptr inttoptr (i64 1 to ptr), ptr @right_label)
  ret i64 0
}

declare void @__quantum__rt__initialize(ptr)
declare void @__quantum__qis__h__body(ptr)
declare void @__quantum__qis__cnot__body(ptr, ptr)
declare void @__quantum__qis__mz__body(ptr, ptr writeonly) #1
declare void @__quantum__rt__tuple_record_output(i64, ptr)
declare void @__quantum__rt__result_record_output(ptr, ptr)

attributes #0 = { "entry_point" "qir_profiles"="base_profile" "output_labeling_schema"="qirb.labels.v1" "required_num_qubits"="2" "required_num_results"="2" }
attributes #1 = { "irreversible" }

!llvm.module.flags = !{!0, !1, !2, !3}
!0 = !{i32 1, !"qir_major_version", i32 2}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
