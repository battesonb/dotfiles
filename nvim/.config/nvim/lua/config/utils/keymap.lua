local M = {}

--- Deletes a key mapping unconditionally, ignoring the mapping if it does not exist. Consider new builtin shortcuts that
--- are not in every version.
---@param name string
---@param mode string
M.keymap_del_unconditional = function(name, mode)
  local keymap = vim.fn.maparg(name, mode, false, true)
  if #keymap ~= 0 then
    vim.keymap.del(mode, name)
  end
end

return M
