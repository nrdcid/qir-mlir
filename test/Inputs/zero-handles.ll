; Null has three contextual roles: initialization argument, qubit 0, result 0.
@zero_label = internal constant [5 x i8] c"zero\00"

define i64 @zero_handles() #0 {
initialize:
  call void @__quantum__rt__initialize(ptr null)
  br label %unitary
unitary:
  call void @__quantum__qis__h__body(ptr null)
  br label %measure
measure:
  call void @__quantum__qis__mz__body(ptr null, ptr writeonly null)
  br label %record
record:
  call void @__quantum__rt__result_record_output(ptr null, ptr @zero_label)
  ret i64 0
}

declare void @__quantum__rt__initialize(ptr)
declare void @__quantum__qis__h__body(ptr)
declare void @__quantum__qis__mz__body(ptr, ptr writeonly) #1
declare void @__quantum__rt__result_record_output(ptr, ptr)
attributes #0 = { "entry_point" "qir_profiles"="base_profile" "output_labeling_schema"="qirb.labels.v1" "required_num_qubits"="1" "required_num_results"="1" }
attributes #1 = { "irreversible" }
!llvm.module.flags = !{!0, !1, !2, !3}
!0 = !{i32 1, !"qir_major_version", i32 2}
!1 = !{i32 7, !"qir_minor_version", i32 0}
!2 = !{i32 1, !"dynamic_qubit_management", i1 false}
!3 = !{i32 1, !"dynamic_result_management", i1 false}
