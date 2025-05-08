return {
  {
    'stevearc/oil.nvim',
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ["<ESC>"] = { "actions.close", mode = "n" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
      },
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      local oil = require('oil')
      oil.setup(opts)

      vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "_", function()
        oil.open_float(vim.fn.getcwd())
      end, { desc = "Open working directory" })
    end,
  },
}
