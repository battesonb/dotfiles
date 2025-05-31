require("config.autocmds")
require("config.behavior")
require("config.keymap")

local nvim_overrides = vim.fn.expand("~/.config/nvim/lua/config/overrides.lua")
if vim.fn.filereadable(nvim_overrides) == 1 then
  require("config.overrides")
end
