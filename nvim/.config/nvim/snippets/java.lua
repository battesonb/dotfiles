local ls = require("luasnip")
local utils = require("plugins.snippets.utils")

local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local nl = utils.new_line
local file_name = utils.file_name
local ref = utils.ref

ls.add_snippets("java", {
  s("catch", {
    t "catch (", i(1, "Exception"), t " ", i(2, "e"), t ") {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("class", {
    t "public class ", file_name(), t " {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("cons", {
    t "public ", file_name(), t " {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("dowhile", {
    t "do {", nl(),
    t "\t", i(0), nl(),
    t "} while (", i(1, "condition"), t ") {",
  }),
  s("foreach", {
    t "for (", i(1, "Type"), t " ", i(2, "name"), t " : ", i(3, "iterable"), t ") {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("fori", c(1, {
    {
      t "for (int i = ", i(1, "0"), t "; i < ", i(2, "max"), t "; i++) {", nl(),
      t "\t", i(3), nl(),
      t "}",
    },
    {
      t "for (int i = ", i(1, "0"), t "; i >= ", i(2, "min"), t "; i--) {", nl(),
      t "\t", i(3), nl(),
      t "}",
    },
  })),
  s("finally", {
    t "finally {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("interface", {
    t "public interface ", file_name(), t " {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("new", {
    i(1, "Type"), t " ", i(2, "name"), t " = new ", ref(1), t "();",
  }),
  s("psvm", {
    t "public static void main(String[] args) {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("record", {
    t "public record ", file_name(), t " {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("serr", {
    t "System.err.println(", i(1), t ");",
  }),
  s("sout", {
    t "System.out.println(", i(1), t ");",
  }),
  s("switch", {
    t "switch (", i(1, "key"), t ") {", nl(),
    t "\tcase ", i(2), t ":", nl(),
    t "\t\t", i(0), nl(),
    t "\t\tbreak;", nl(),
    t "\tdefault:", nl(),
    t "\t\tbreak;", nl(),
    t "}",
  }),
  s("trywith", {
    t "try (", i(1, "resource"), t ") {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
  s("while", {
    t "while (", i(1, "condition"), t ") {", nl(),
    t "\t", i(0), nl(),
    t "}",
  }),
})
