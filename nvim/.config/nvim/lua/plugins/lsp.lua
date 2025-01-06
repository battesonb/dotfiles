return {
  {
    "neovim/nvim-lspconfig",
    priority = 250,
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          "williamboman/mason.nvim",
        },
        config = function()
          local masonlspconfig = require("mason-lspconfig")
          masonlspconfig.setup({
            automatic_installation = true,
          })

          masonlspconfig.setup_handlers({
            function(server_name)
              local config = {
                capabilities = require("cmp_nvim_lsp").default_capabilities()
              }
              require("lspconfig")[server_name].setup(config)
            end,
          })
        end
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        bashls = {},
        clangd = {},
        gopls = {},
        jdtls = {},
        lua_ls = {},
        marksman = {},
        pylsp = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = require("plugins.lsp.rust").project_features(),
              }
            }
          },
        },
        solargraph = {
          root_dir = vim.fs.root(vim.fn.getcwd(), { ".git", "Gemfile", "Rakefile" })
        },
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "sass",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "rust",
          },
          root_dir = require("plugins.lsp.tailwind").root_dir,
          settings = {
            tailwindCSS = {
              includeLanguages = {
                rust = "html"
              }
            }
          },
        },
        ts_ls = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      for server, config in pairs(opts.servers) do
        config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspconfig[server].setup(config)
      end

      if vim.diagnostic.jump then
        vim.keymap.set("n", "[g", function()
          vim.diagnostic.jump({ count = -1 })
        end)
        vim.keymap.set("n", "]g", function()
          vim.diagnostic.jump({ count = 1 })
        end)
      else
        vim.keymap.set("n", "[g", function()
          vim.diagnostic.goto_prev()
        end)
        vim.keymap.set("n", "]g", function()
          vim.diagnostic.goto_next()
        end)
      end

      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
      vim.keymap.set("n", "gr", vim.lsp.buf.references)
      vim.keymap.set("n", "gs", vim.lsp.buf.document_symbol)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set({ "n", "v" }, "<leader>rf", vim.lsp.buf.format)

      -- I didn't know there are new defaults, and I'm too stubborn to change my ways right now!
      local keymap = require("config.utils.keymap")
      keymap.keymap_del_unconditional("grr", "n")
      keymap.keymap_del_unconditional("gri", "n")
      keymap.keymap_del_unconditional("gra", "n")
      keymap.keymap_del_unconditional("grn", "n")
    end
  }
}
