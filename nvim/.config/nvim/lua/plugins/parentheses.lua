return {
  "HiPhish/rainbow-delimiters.nvim",
  {
    "julienvincent/nvim-paredit",
    config = function()
      local paredit = require("nvim-paredit")
      paredit.setup({
        keys = {
          ["("] = {
            paredit.api.move_to_parent_form_start,
            "Jump to parent form's head",
            repeatable = false,
            mode = { "n", "x" },
          },
          [")"] = {
            paredit.api.move_to_parent_form_end,
            "Jump to parent form's tail",
            repeatable = false,
            mode = { "n", "x" },
          },
        },
      })
    end
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      require("autoclose").setup({
        keys = {
          ["'"] = { disabled_filetypes = { "lisp", "rust" } },
          ["`"] = { disabled_filetypes = { "lisp" } },
        },
        options = {
          disable_when_touch = true,
          disable_command_mode = true,
          disabled_filetypes = { "TelescopePrompt" },
        },
      })
    end
  }
}
