local M = {}

---@param tbl table
---@return table
M.copy = function(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    result[key] = value
  end
  return result
end

--- Pushes a value onto a table. If this table has non-integer keys, nonsense is produced.
M.push = function(tbl, value)
  tbl[#tbl + 1] = value
end

--- Concatenates a variable number of tables together
---@return table
M.concat = function(...)
  local result = {}
  for _, tbl in ipairs({...}) do
    for _, value in ipairs(tbl) do
      M.push(result, value)
    end
  end
  return result
end

---@param tbl table
---@param func function
---@return table
M.map = function(tbl, func)
  local result = {}
  for key, value in pairs(tbl) do
    result[key] = func(value)
  end
  return result
end

return M
