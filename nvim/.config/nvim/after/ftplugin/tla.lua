local tla = require('config.tla')

vim.keymap.set({ "n", "v" }, "<leader>x", tla.evaluate_expression, { desc = "TLA Evaluate Expression" })
