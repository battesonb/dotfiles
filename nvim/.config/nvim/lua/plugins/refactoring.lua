return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    lazy = false,
    opts = {},
    init = function()
      local map = {
        ["Extract Block"] = "<leader>rbe",
        ["Extract Block To File"] = "<leader>rbfe",
        ["Extract Variable"] = "<leader>rve",
        ["Inline Variable"] = "<leader>rvi",
        ["Extract Function"] = "<leader>rme", -- m, because f is for format (mnemonic is method, even if its not)
        ["Extract Function To File"] = "<leader>rmfe",
        ["Inline Function"] = "<leader>rmi",
      }

      for action, keys in pairs(map) do
        vim.keymap.set(
          { "n", "x" },
          keys,
          function() return require('refactoring').refactor(action) end,
          { expr = true })
      end
    end,
  },
}
