local M = {}

---@param s string
---@return string
M.trim = function(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

return M
