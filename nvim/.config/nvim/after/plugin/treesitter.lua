local configs = require("nvim-treesitter.configs")
local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

local languages = { "smithy", "vim", "wgsl" }

local function hasValue(table, value)
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
	ignore_install = { "lua", "vim" },
	highlight = {
		enable = true,
		disable = function(lang)
			-- To support running both the Neovim LSP and coc.nvim.
			return not hasValue(languages, lang)
		end
	}
})
