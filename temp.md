ok
Processing tests/11_declare_pos.tea -> tests/11_declare_pos.ast
Typecheck passed
type check passed

---

ok
Processing tests/12_func_not_defined.tea -> tests/12_func_not_defined.ast
Typecheck error in line 6, col 17: function not defined
Typecheck error in line 6, col 17: Function not defined!

---

ok
Processing tests/15_duplicate_function.tea -> tests/15_duplicate_function.ast
Typecheck error in line 16, col 1: the function with the same name has been declared
Typecheck error in line 16, col 1: The function return type doesn't match the declaration!

---

ok
Processing tests/06_member_not_defined.tea -> tests/06_member_not_defined.ast
Typecheck error in line 10, col 5: no such member
line 10, col 5: member 'tail' is not defined.

---

ok
Processing tests/14_local_global_duplicate.tea -> tests/14_local_global_duplicate.ast
Typecheck error in line 10, col 9: local variables duplicates with global params
key: Typecheck error in line 10, col 9: This id is already defined!

---

ok
Processing tests/13_active_domain.tea -> tests/13_active_domain.ast
Typecheck passed!
Typecheck passed!

---

ok
Processing tests/07_function_param.tea -> tests/07_function_param.ast
Typecheck error in line 14, col 28: this parameter type is not same as defined
Typecheck error in line 14, col 28: The expression of right value doesn't match the given left type!

---

ok
Processing tests/05_duplicate_definition.tea -> tests/05_duplicate_definition.ast
Typecheck error in line 7, col 9: local variables duplicates with local params
line 7, col 9: local variables dplicates with function params.

---

ok
Processing tests/01_var_not_defined.tea -> tests/01_var_not_defined.ast
Typecheck error in line 6, col 5: this variable is not defined
var c on line 6, col 5 is not defined.

---

ok
Processing tests/10_comprehensive_case.tea -> tests/10_comprehensive_case.ast
Typecheck passed!
type check passed.

---

ok
Processing tests/08_if_bool_comp.tea -> tests/08_if_bool_comp.ast
Typecheck error in line 15, col 8: left item is not int scalar
line 15, col 8: MyStruct is not comparable with int.

---

ok
Processing tests/04_local_global_vars.tea -> tests/04_local_global_vars.ast
line 12, col 9: duplicate definition
line 12, col 8: duplicate definition.

---

ok
Processing tests/09_not_struct.tea -> tests/09_not_struct.ast
Typecheck error in line 13, col 5: this variable is not a struct scalar type
line 13, col 5: a is not a struct.

---

ok
Processing tests/02_assign_to_func.tea -> tests/02_assign_to_func.ast
Typecheck error in line 6, col 5: function can not be assigned
cannot assign a value to function main on line 6, col 5.

---

ok
Processing tests/03_func_ret_not_match.tea -> tests/03_func_ret_not_match.ast
Typecheck error in line 8, col 1: the function with the same name has been declared
line 8, col 1: The function return type doesn't match the given left type.