vim.keymap.set("n", "n", "nzzzv", { noremap = true }) -- center next in search
vim.keymap.set("n", "N", "Nzzzv", { noremap = true }) -- center previous in search
vim.keymap.set("n", "J", "mzJ`z", { noremap = true }) -- keep cursor stationary on line joins
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")          -- move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")          -- move selection up
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")      -- move line down
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")      -- move line up
vim.keymap.set("x", "<leader>p", "\"_dP")             -- keep value in register on paste

-- Replace word under cursor (see cmdline.txt for more)
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
