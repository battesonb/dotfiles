; extends

; Support injections for the code macro
(macro
  name: (macro_name) @_macro_name
  params: (macro_params
            (macro_param
              name: (param_name) @_param_name
              value: (param_value
                       (string
                         (string_content) @injection.language))))
  (macro_content) @injection.content
  (#match? @_macro_name "^code$")
  (#match? @_param_name "^language$"))

; Support the html macro
(macro
  name: (macro_name) @_macro_name
  (macro_content) @injection.content
  (#match? @_macro_name "^html$")
  (#set! injection.language "html"))
