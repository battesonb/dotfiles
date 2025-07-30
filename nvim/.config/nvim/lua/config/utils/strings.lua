local M = {}

---@param s string
---@return string
M.trim = function(s)
  local res = s:gsub("^%s+", ""):gsub("%s+$", "")
  return res
end

return M
