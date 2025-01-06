return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local ls = require("luasnip")

      cmp.setup({
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = {
            i = cmp.mapping.complete(),
          },
          ["<C-y>"] = {
            i = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          },
          ["<CR>"] = {
            i = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
          },
        }),
        sources = {
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              -- Remove LSP snippets
              return entry:get_kind() ~= cmp.lsp.CompletionItemKind.Snippet
            end
          },
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

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
    end
  },
}
