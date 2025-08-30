local ls = require("luasnip")
local utils = require("plugins.snippets.utils")

local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local nl = utils.new_line
local file_name = utils.file_name
local ref = utils.ref

-- Turns `.../src/main/java/org/package/Foo.java` into `org.package`. Fallback is `org.example`.
local function package_name(_, _)
  local filepath = vim.fn.expand("%:p")
  local parts = vim.split(filepath, "/")
  local idx = vim.fn.index(parts, "java")
  local suggested_package = "org.example"
  if idx ~= -1 and idx + 1 < #parts then
    local pkg_parts = vim.list_slice(parts, idx + 2, #parts - 1)
    suggested_package = table.concat(pkg_parts, ".")
  end

  return sn(nil, {
    i(1, suggested_package)
  })
end

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
  s("package", {
    t "package ", d(1, package_name, {}), t ";",
  }),
  s("psvm", {
    t "public static void main(final String[] args) {", nl(),
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
