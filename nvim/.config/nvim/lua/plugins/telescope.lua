return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      local opts = { pickers = {} }

      local pickers = { "buffers", "git_commits", "find_files", "live_grep", "help_tags", "man_pages", "treesitter" }
      for _, picker in ipairs(pickers) do
        opts.pickers[picker] = {
          theme = "ivy"
        }
      end

      require("telescope").setup(opts)

      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
      vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Find Git commits" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find grep" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
      vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Find man pages" })
      vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find treesitter" })

      -- Meta
      vim.keymap.set("n", "<leader>nc", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config")
        })
      end, { desc = "Neovim config" })
      vim.keymap.set("n", "<leader>np", function()
        builtin.find_files({
          cwd = vim.fn.stdpath("data") .. "/lazy"
        })
      end, { desc = "Neovim plugins"})
    end
  },
}
