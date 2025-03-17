local ls = require("luasnip")

local t = ls.text_node

local M = {}

M.new_line = function() return t{"", ""} end

return M
