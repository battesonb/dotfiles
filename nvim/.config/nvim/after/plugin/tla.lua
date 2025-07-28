local tla = require('config.tla')

tla.setup()

vim.keymap.set({ "n", "v" }, "<leader>tla", tla.picker, { desc = "TLA Picker" })
