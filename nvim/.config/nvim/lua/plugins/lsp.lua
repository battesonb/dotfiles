return {
  {
    "neovim/nvim-lspconfig",
    priority = 250,
    dependencies = {
      "hrsh7th/nvim-cmp",
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
        dartls = {
          {
            cmd = { "dart", 'language-server', '--protocol=lsp' },
          }
        },
        gopls = {},
        jdtls = {
          cmd = {
            "jdtls",
            ("-configuration:%s"):format("$HOME/runner/.cache/jdtls/config"),
            ("-data:%s"):format("$HOME/runner/.cache/jdtls/workspace"),
            ("--jvm-args=-javaagent:%s"):format("$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"),
          },
        },
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
        vtsls = {},
      },
    },
    config = function(_, opts)
      vim.lsp.inlay_hint.enable()

      for server, config in pairs(opts.servers) do
        config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config(server, config)
      end

      if vim.diagnostic.jump then
        vim.keymap.set("n", "[g", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end)
        vim.keymap.set("n", "]g", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end)
      else
        vim.keymap.set("n", "[g", function()
          vim.diagnostic.get_prev({ float = true })
        end)
        vim.keymap.set("n", "]g", function()
          vim.diagnostic.get_next({ float = true })
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
      vim.keymap.set("n", "<leader>ci", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set({ "n", "v" }, "<leader>rf", vim.lsp.buf.format)

      -- I didn't know there are new defaults, and I'm too stubborn to change my ways right now!
      local keymap = require("config.utils.keymap")
      keymap.keymap_del_unconditional("grr", "n")
      keymap.keymap_del_unconditional("gri", "n")
      keymap.keymap_del_unconditional("gra", "n")
      keymap.keymap_del_unconditional("grn", "n")
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local masonlspconfig = require("mason-lspconfig")
      masonlspconfig.setup({})
    end
  },
}
