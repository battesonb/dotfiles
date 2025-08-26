local ls = require("luasnip")
local utils = require("plugins.snippets.utils")

local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local nl = utils.new_line
local ref = utils.ref

ls.add_snippets("lua", {
  s("class", {
    i(1, "M"), t " = {}", nl(),
    nl(),
    t "function ", ref(1), t ":", i(2, "new"), t "(o", i(3, ""), t ")", nl(),
    t "\to = o or {}", nl(),
    t "\tsetmetatable(o, self)", nl(),
    t "\tself.__index = self", nl(),
    t "\treturn o", nl(),
    t "end"
  }),
  s("foreach", c(1, {
    {
      t "for ", i(1, "i"), t ", ", i(2, "x"), t " in ipairs(", i(3, "t"), t ") do", nl(),
      t "\t", i(0), nl(),
      t "end",
    },
    {
      t "for ", i(1, "k"), t ", ", i(2, "v"), t " in pairs(", i(3, "t"), t ") do", nl(),
      t "\t", i(0), nl(),
      t "end",
    },
  })),
  s("fori", {
    t "for ", i(1, "i"), t " = ", i(2, "1"), t ", ", i(3, "10"), t " do", nl(),
    t "\t", i(0), nl(),
    t "end",
  }),
  s("function", c(1, {
    {
      t "function ", i(1, "name"), t "(", i(2, ""), t ")", nl(),
      t "\t", i(0), nl(),
      t "end",
    },
    {
      t "function(", i(2, ""), t ")", nl(),
      t "\t", i(0), nl(),
      t "end",
    },
  })),
  s("module", {
    i(1, "M"), t " = {}", nl(),
    nl(),
    t "M", t ".", i(2, "name"), t " = function(", i(3, ""), t")", nl(),
    t "\t", i(0), nl(),
    t "end"
  }),
  s("while", {
    t "while ", i(1, "true"), t " do", nl(),
    t "\t", i(0), nl(),
    t "end",
  }),
})
