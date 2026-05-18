; Support for nvim-treesitter-context

(impl_machine_decl
  name: (identifier)
  (_) @context.end) @context

(state_decl
  name: (identifier)
  (_) @context.end) @context

(on_event_do_action
  (_) @context.end) @context

(state_entry
  (_) @context.end) @context

(p_fun_decl
  name: (identifier)
  (_) @context.end) @context

(if_stmt (_) @context.end) @context
(while_stmt (_) @context.end) @context
(foreach_stmt (_) @context.end) @context
