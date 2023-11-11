local builtin = require("telescope.builtin")
local telescope = require("telescope")

telescope.setup({
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
		}
	}
})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
