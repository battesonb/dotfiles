local ls = require("luasnip")
local utils = require("plugins.snippets.utils")

local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local nl = utils.new_line
local ref = utils.ref

ls.add_snippets("go", {
  s("case", {
    t "case ", i(1, "value"), t ":", nl(),
    t "\t",
  }),
  s("enum", {
    t "type ", i(1, "Enum", { key = "enum" }), t " int", nl(),
    nl(),
    t "const (", nl(),
    t "\t", ref(1), i(2, "Variant1"), t " ", ref(1), t " = iota", nl(),
    t "\t", ref(1), i(3, "Variant2"), nl(),
    t ")",
  }),
  s("iferr", {
    t "if err != nil {", nl(),
    t "\t return ", c(1, {
    {
      i(1, "err"),
    },
    {
      t "nil, ", i(1, "err"),
    },
    {
      t "fmt.Errorf(\"", i(1, "failed"), t ": %w\", err)",
    },
    {
      t "nil, fmt.Errorf(\"", i(1, "failed"), t ": %w\", err)",
    },
  }), nl(),
    t "}",
  }),
  s("func", {
    t "func ", i(1, "name"), t "(", i(2), t ") ", i(3), t "{", nl(),
    t "\t", i(4), nl(),
    t "}"
  }),
  s("interface", {
    t "type ", i(1, "Interface"), t " interface {", nl(),
    t "\t", i(2), nl(),
    t "}",
  }),
  s("json", {
    t "`json:\"", i(1), t"\"`",
  }),
  s("main", {
    t "func main() {", nl(),
    t "\t", i(1), nl(),
    t "}", nl(),
  }),
  s("method", {
    t "func (", i(1, "receiver"), t " ", i(2, "type"), t ") ", i(3, "name"), t "(", i(4), t ") ", i(5), t "{", nl(),
    t "\t", i(6), nl(),
    t "}"
  }),
  s("struct", {
    t "type ", i(1, "Struct"), t " struct {", nl(),
    t "\t", i(2), nl(),
    t "}",
  }),
  s("switch", {
    t "switch ", i(1, "expression"), t " {", nl(),
    t "case ", i(2, ""), t ":", nl(),
    t "}"
  }),
  s("test", {
    t "func Test", i(1, "Name"), t "(t *testing.T) {", nl(),
    t "\t", i(2, ""), nl(),
    t "}", nl(),
  }),
  s("tcs", {
    t "tcs := []struct{", nl(),
    t "\tname string", nl(),
    t "}{", nl(),
    t "\t{", nl(),
    t "\t\tname: \"", i(1, "test name"), t "\",", nl(),
    t "\t},", nl(),
    t "}", nl(),
    nl(),
    t "for _, tc := range tcs {", nl(),
    t "\tt.Run(tc.name, func(t *testing.T) {", nl(),
    t "\t\t", i(2), nl(),
    t "\t})", nl(),
    t "}",
  }),
})
