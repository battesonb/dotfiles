local ls = require("luasnip")
local utils = require("plugins.snippets.utils")
local tbl = require("config.utils.table")

local c = ls.choice_node
local i = ls.insert_node
local s = ls.snippet
local t = ls.text_node
local nl = utils.new_line
local file_name = utils.file_name

local prefix_keywords = {
  "ASSUME",
  "CONSTANT",
  "ENABLED",
  "EXTENDS",
  "IN",
  "INSTANCE",
  "LET",
  "LOCAL",
  "RECURSIVE",
  "UNCHANGED",
  "VARIABLE",
  "THEOREM",
  "assert",
  "await",
  "call",
  "goto",
}

local mappings = {
  {
    trig = "always",
    desc = "□",
    content = "[]",
  },
  {
    trig = "cartesian",
    desc = "×",
    content = "\\X ",
  },
  {
    trig = "cons",
    desc = "Concatenate",
    content = "\\o ",
  },
  {
    trig = "difference",
    content = "\\ ",
  },
  {
    trig = "eventually",
    desc = "◇",
    content = "<>",
  },
  {
    trig = "leadsto",
    content = "~> ",
  },
  {
    trig = "intersect",
    desc = "∩",
    content = "\\intersect ",
  },
  {
    trig = "union",
    desc = "∪",
    content = "\\union ",
  },
  {
    trig = "and",
    desc = "∧",
    content = "/\\ ",
  },
  {
    trig = "implies",
    desc = "⇒",
    content = "=> ",
  },
  {
    trig = "or",
    desc = "∨",
    content = "\\/ ",
  },
  {
    trig = "not",
    content = "~",
  },
}

local keywords = {
  "FALSE",
  "TRUE",
  "FiniteSets",
  "Integers",
  "Naturals",
  "Sequences",
  "TLC",
}

ls.add_snippets("tla", tbl.concat({
    s("module", {
      t "---- MODULE ", file_name(), t " ----", nl(),
      t "EXTENDS TLC", nl(),
      nl(),
      i(0), nl(),
      t "====",
    }),
    s("pluscal", {
      t "(*--algorithm ", file_name(), nl(),
      i(0), nl(),
      t "begin", nl(),
      t "\tskip;", nl(),
      t "end algorithm; *)",
    }),
    s("define", {
      t "define", nl(),
      t "\t", i(0), nl(),
      t "end define;",
    }),
    s("either", {
      t "either", nl(),
      t "\t", i(1, "skip;"), nl(),
      t "or", nl(),
      t "\t", i(2, "skip;"), nl(),
      t "end either;",
    }),
    s("if", c(1, {
      {
        t "if ", i(1, "condition"), t " then", nl(),
        t "\t", i(2, "skip;"), nl(),
        t "end if;",
      },
      {
        t "if ", i(1, "condition"), t " then", nl(),
        t "\t", i(2, "skip;"), nl(),
        t "else", nl(),
        t "\t", i(3, "skip;"), nl(),
        t "end if;",
      },
    })),
    s("macro", {
      t "macro ", i(1, "name"), t "(", i(2, "params"), t ") begin", nl(),
      t "\t", i(3, "skip;"), nl(),
      t "end macro;",
    }),
    s("procedure", {
      t "procedure ", i(1, "name"), t "(", i(2, "params"), t ")", nl(),
      nl(),
      t "begin", nl(),
      t "\t", i(3, "return;"), nl(),
      t "end procedure;",
    }),
    s("process", {
      t "process ", i(1, "name"), t " ", i(2, "value"), nl(),
      t "begin", nl(),
      t "\t", i(3, "skip;"), nl(),
      t "end process;",
    }),
    s("variable", {
      c(1, {
        {
          t "VARIABLE ", i(1, "name"),
        },
        {
          t "variable", nl(),
          t "\t", i(1, "name"),
        },
      }),
    }),
    s("with", {
      t "with ", i(1, "assignment"), t " do", nl(),
      t "\t", i(3, "skip;"),
      t "end with;",
    }),
    s({ trig = "WF", desc = "Weak fairness" }, {
      t "WF_", i(1, "vars"),
    }),
    s({ trig = "SF", desc = "Strong fairness" }, {
      t "SF_", i(1, "vars"),
    }),
    s("while", {
      t "while ", i(1, "condition"), t " do", nl(),
      t "\t", i(2, "skip;"), nl(),
      t "end while;",
    }),
  },
  vim.iter(keywords):map(function(value)
    return s(value, {
      t(value),
    })
  end):totable(),
  vim.iter(mappings):map(function(value)
    return s(value, {
      t(value.content),
    })
  end):totable(),
  vim.iter(prefix_keywords):map(function(value)
    return s(value, {
      t(value), t " ", i(0),
    })
  end):totable()
))
