vim.g.mapleader = " "       -- global leader
vim.g.maplocalleader = "\\" -- file type local leader

vim.o.spell = true          -- enable spell check

vim.o.number = true         -- enable line numbers
vim.o.relativenumber = true -- enable relative line numbers
vim.o.showmatch = true      -- showing matching parentheses

vim.o.tabstop = 2           -- number of visual spaces per tab
vim.o.softtabstop = 2       -- number of spaces in tab when editing
vim.o.expandtab = true      -- tabs are spaces
vim.o.shiftwidth = 2        -- shift width is the same as our tab size
vim.o.list = true           -- shows a set of normally invisible characters
vim.o.listchars = table.concat({
  "tab:▸·",
  "trail:·",
  "eol:↩"
}, ",")

vim.o.hlsearch = false          -- don't highlight searches
vim.o.incsearch = true          -- incremental search only
vim.o.ic = true                 -- ignore case sensitive searching
vim.o.smartcase = true          -- unless there is a capital letter in the search
vim.o.clipboard = "unnamedplus" -- copy to real clipboard

local undo_breakpoints = { ",", ".", "!", "?" }
for i = 1, #undo_breakpoints do
  local breakpoint = undo_breakpoints[i]
  vim.keymap.set("i", breakpoint, breakpoint .. "<C-g>u", { noremap = true })
end

require("config")
require("config.lazy")

vim.api.nvim_set_hl(0, "SpellBad", { sp = "#fcd058", undercurl = true })
