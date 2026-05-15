return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.p = {
        install_info = {
          url = "https://github.com/battesonb/tree-sitter-p",
          branch = "main",
          files = { "src/parser.c" },
          queries = 'queries',
        },
        filetype = "p",
      }

      local configs = require("nvim-treesitter.configs")

      configs.setup({
        modules = {},
        ensure_installed = {
          "c",
          "go",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "rust",
          "typescript",
          "vim",
          "vimdoc",
        },
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
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99
    end
  },
  "nvim-treesitter/nvim-treesitter-context",
}
