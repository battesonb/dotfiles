return {
  {
    "mfussenegger/nvim-lint",
    priority = 250,
    dependencies = {
      "williamboman/mason.nvim",
      "rshkarin/mason-nvim-lint",
    },
    config = function()
      local masonlint = require("mason-nvim-lint")
      local lint = require("lint")

      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        python = { "ruff" },
        bash = { "shellcheck" },
      }

      masonlint.setup({
        automatic_installation = true,
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  }
}
