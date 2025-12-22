-- Prevent attempted suspend on Windows
if vim.fn.has("win32") ~= 0 or vim.fn.has("win64") ~= 0 then
  vim.keymap.set({ "n", "v" }, "<C-z>", function()
    vim.notify("Suspend is not available on Windows", vim.log.levels.ERROR)
  end)
end

-- Add more undo breakpoints
local undo_breakpoints = { ",", ".", "!", "?" }
for i = 1, #undo_breakpoints do
  local breakpoint = undo_breakpoints[i]
  vim.keymap.set("i", breakpoint, breakpoint .. "<C-g>u", { noremap = true })
end

-- Add Neovim overrides
local nvim_overrides = vim.fn.expand("~/.config/nvim/lua/config/overrides.lua")
if vim.fn.filereadable(nvim_overrides) == 1 then
  require("config.overrides")
end
