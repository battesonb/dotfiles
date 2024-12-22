-- Meta configuration for executing Lua code in Neovim
vim.keymap.set("n", "<leader>cx", ":!lua %<CR>")
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
