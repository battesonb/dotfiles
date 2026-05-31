M = {}

--- Conditionally loads the provided path as a module (if it exists). If not, returns an empty
--- table.
---@param path string
---@return table
M.load_module = function(path)
  local expanded_path = vim.fn.expand(path)
  if vim.fn.filereadable(expanded_path) == 1 then
    vim.print(expanded_path)
    local module_path = expanded_path:match("/lua/(.+)%.lua"):gsub("/", ".")
    return require(module_path)
  else
    return {}
  end
end

---Returns either the `require` of a module or an empty table.
---@param module string
---@return table
function M.require_optional(module)
  local ok, mod = pcall(require, module)
  if not ok then return {} end
  return mod
end

return M
