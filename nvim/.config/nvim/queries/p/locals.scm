; Locals for telescope symbol lookup support

; Types
(top_decl
  (impl_machine_decl
    name: (identifier) @local.definition.type))
(top_decl
  (spec_machine_decl
    name: (identifier) @local.definition.type))
(top_decl
  (type_def_decl
    name: (identifier) @local.definition.type))
(top_decl
  (event_decl
    name: (identifier) @local.definition.type))

; Enums
(top_decl
  (enum_type_def_decl
    name: (identifier) @local.definition.enum))

; States / Methods
(machine_entry
  (fun_decl
    (p_fun_decl
      name: (identifier) @local.definition.method)))
(machine_entry
  (state_decl
      name: (identifier) @local.definition.method))

; Functions / Tests
(top_decl
  (fun_decl
    (p_fun_decl
      name: (identifier) @local.definition.function)))
(top_decl
  (test_decl
    (safety_test_decl
      test_name: (identifier) @local.definition.function)))

; Fields
(machine_entry
  (var_decl
    (iden_list
      (identifier) @local.definition.field)))

; Scopes
[
  (compound_stmt)
] @local.scope
