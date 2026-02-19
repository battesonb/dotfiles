local path = require("config.utils.path")

require("config.options")
require("config.autocmds")
require("config.behavior")
require("config.keymap")

-- Add Neovim overrides
path.load_module("~/.config/nvim/lua/config/overrides.lua")

-- Require lazy.nvim last
require("config.lazy")

-- Replace theme spelling error highlight with more muted yellow/orange.
vim.api.nvim_set_hl(0, "SpellBad", { sp = "#c4a262", undercurl = true })
