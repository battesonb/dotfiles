local ls = require("luasnip")
local utils = require("plugins.snippets.utils")
local tbl = require("config.utils.table")

local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local nl = utils.new_line

ls.add_snippets("xwiki", tbl.concat(
  {
    s("bold", {
      t "**", i(1), t "**",
    }),
    s("definition", {
      t "; ", i(1, "term"), nl(),
      t ": ", i(1, "definition"),
    }),
    s("group", {
      t "(((", i(1), t ")))",
    }),
    s("hr", {
      t "----", nl(),
    }),
    s("html", {
      t "{{html}}", i(1), t "{{/html}}",
    }),
    s("linebreak", {
      t "\\\\", nl(),
    }),
    s("link", c(1, {
      {
        t "[[", i(1), t "]]",
      },
      {
        t "[[", i(1, "label"), t ">>", i(2), t "]]",
      },
    })),
    s("italics", {
      t "//", i(1), t "//",
    }),
    s("monospace", {
      t "##", i(1), t "##",
    }),
    s("strikeout", {
      t "--", i(1), t "--",
    }),
    s("subscript", {
      t ",,", i(1), t ",,",
    }),
    s("superscript", {
      t "^^", i(1), t "^^",
    }),
    s("underline", {
      t "__", i(1), t "__",
    }),
    s("verbatim", {
      t "{{{", i(1), t "}}}",
    }),
    s("param", {
      t "(% ", i(1, "attrs"), t " %)",
    }),
  },
  vim.iter({1, 2, 3, 4, 5, 6}):map(function(v)
    local equals = string.rep("=", v)
    return s(string.format("h%d", v), {
      t(equals), t " ", i(1, "Heading"), t " ", t(equals),
    })
  end):totable()
))
