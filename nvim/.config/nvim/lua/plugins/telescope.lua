return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local builtin = require("telescope.builtin")

      local opts = {
        pickers = {
          buffers = {},
          git_commits = {},
          find_files = {
            file_ignore_patterns = { "node_modules", ".git" },
            hidden = true,
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  vim.cmd(string.format("silent cd %s", dir))
                end
              }
            },
          },
          help_tags = {},
          man_pages = {},
          treesitter = {},
        }
      }

      for _, picker in ipairs(opts.pickers) do
        opts.pickers[picker].theme = "ivy"
      end

      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
      require "config.telescope.focusgrep".setup()

      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
      vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Find Git commits" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
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
      end, { desc = "Neovim plugins" })
    end
  },
}
