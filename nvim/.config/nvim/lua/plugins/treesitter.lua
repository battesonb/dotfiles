return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        modules = {},
        ensure_installed = { "c", "go", "rust", "lua", "vim", "vimdoc", "query", "typescript", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
    end
  },
  "nvim-treesitter/nvim-treesitter-context",
}
