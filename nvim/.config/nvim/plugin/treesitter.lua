local configs = require("nvim-treesitter.configs")
local List = require("plenary.collections.py_list")

local skipHighlights = { "wgsl" }

function hasValue(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

configs.setup({
	ensure_installed = {
		"rust",
		"typescript",
	},
	sync_install = true,
	auto_install = false,
	ignore_install = { "vim" },
	highlight = {
		enable = true,
		disable = function(lang, bufnr)
			-- To support running both the Neovim LSP and coc.nvim.
			return not hasValue(skipHighlights, lang)
		end
	}
})