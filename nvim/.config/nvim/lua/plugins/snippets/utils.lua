local ls = require("luasnip")

local t = ls.text_node
local f = ls.function_node

local M = {}

M.new_line = function() return t { "", "" } end

M.ref = function(index)
  return f(function(args) return args[index][1] end, { index })
end

M.file_name = function()
  return f(function(_, snip)
    local file = snip.env.TM_FILENAME
    return string.sub(file, 1, (string.find(file, ".", 1, true) or #file + 1) - 1)
  end, {})
end

return M
