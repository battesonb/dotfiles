local M = {}

---@param tbl table
---@return table
M.keys = function(tbl)
  local result = {}
  for key, _ in pairs(tbl) do
    M.push(result, key)
  end
  return result
end

---- Pushes value onto a table. If this table has non-integer keys, nonsense is produced.
M.push = function(tbl, value)
  tbl[#tbl + 1] = value
end


--- Concatenates a variable number of tables together
---@return table
M.concat = function(...)
  return vim.iter({ ... }):flatten()
end

return M
