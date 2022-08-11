local telescope = require("telescope")
local refactoring = require('refactoring')

telescope.setup({
	pickers = {
		find_files = {
			hidden = true
		}
	}
})

refactoring.setup({})

telescope.load_extension("refactoring")

vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
