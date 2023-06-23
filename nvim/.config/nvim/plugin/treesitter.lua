local configs = require("nvim-treesitter.configs")

local languages = { "smithy", "wgsl" }

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
	ignore_install = { "vim" },
	highlight = {
		enable = true,
		disable = function(lang, bufnr)
			-- To support running both the Neovim LSP and coc.nvim.
			return not hasValue(languages, lang)
		end
	}
})
