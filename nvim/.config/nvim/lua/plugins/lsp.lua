return {
  {
    "neovim/nvim-lspconfig",
    priority = 250,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          "williamboman/mason.nvim",
        },
        config = function()
          require("mason-lspconfig").setup({
            automatic_installation = true,
          })
        end
      },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          {
            'mireq/luasnip-snippets',
            dependencies = { 'L3MON4D3/LuaSnip' },
            init = function()
              -- Mandatory setup function
              require('luasnip_snippets.common.snip_utils').setup()
            end

          },
          {
            "L3MON4D3/LuaSnip",
            lazy = true,
            init = function()
              local ls = require('luasnip')
              local lua = require("luasnip.loaders.from_lua")

              ls.setup({
                load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
                ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
                enable_autosnippets = true,
              })

              ls.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

              lua.load({ paths = { vim.fn.stdpath("config") .. "/snippets/" } })
            end
          },
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-nvim-lsp" },
          { "saadparwaiz1/cmp_luasnip" },
        },
        config = function()
          local cmp = require("cmp")
          local ls = require("luasnip")

          cmp.setup({
            mapping = {
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-p>"] = function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif ls.locally_jumpable(-1) then
                  ls.jump(-1)
                else
                  fallback()
                end
              end,
              ["<C-n>"] = function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif ls.expand_or_jumpable() then
                  ls.expand_or_jump()
                else
                  fallback()
                end
              end,
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-d>"] = cmp.mapping.scroll_docs(-4),
              ["<C-e>"] = cmp.mapping.close(),
              ["<C-y>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              }),
              ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              }),
            },
            sources = {
              { name = "nvim_lsp" },
              { name = "path" },
              { name = "luasnip" },
              {
                name = "buffer",
                option = {
                  get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                  end
                },
              },
            },
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
        rust_analyzer = {},
        solargraph = {
          root_dir = vim.fs.root(vim.fn.getcwd(), { ".git", "Gemfile", "Rakefile" })
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

      vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition)
      vim.keymap.set("n", "gr", vim.lsp.buf.references)
      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
      vim.keymap.set({ "n", "v" }, "<leader>rf", vim.lsp.buf.format)
    end
  }
}
