local ls = require("luasnip")

local t = ls.text_node
local f = ls.function_node

local M = {}

M.new_line = function() return t { "", "" } end

M.ref = function(index)
  return f(function(args) return args[index][1] end, { index })
end

return M
