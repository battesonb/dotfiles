local ls = require("luasnip")
local utils = require("plugins.snippets.utils")

local c = ls.choice_node
local i = ls.insert_node
local r = ls.restore_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local nl = utils.new_line

ls.add_snippets("wgsl", {
  s("const", {
    t "const ", i(1), t ": ", i(2), t" = ", i(3), t ";"
  }),
  s("fn", {
    c(1, {
      sn(nil, {
        t "fn ", r(1, "fn_name"), t "(", r(2, "params"), t ") -> ", r(3, "return"), t " {", nl(),
        t "\t", r(4, "body"), nl(),
        t "}",
      }),
      sn(nil, {
        t "fn ", r(1, "fn_name"), t "(", r(2, "params"), t ")", i(3), t " {", nl(),
        t "\t", r(4, "body"), nl(),
        t "}",
      }),
    })
  }, {
    stored = {
      ["fn_name"] = i(1, "main"),
      ["return"] = i(2, "vec4f"),
      ["params"] = i(3),
      ["body"] = i(4),
    },
  }),
  s("let", {
    t "let ", i(1), t ": ", i(2), t" = ", i(3), t ";"
  }),
  s("struct", {
    t "struct ", i(1, "Struct"), t " {", nl(),
    t "\t", i(2), nl(),
    t "};",
  }),
  s("var", {
    t "var ", i(1), t ": ", i(2), t" = ", i(3), t ";"
  }),
})
