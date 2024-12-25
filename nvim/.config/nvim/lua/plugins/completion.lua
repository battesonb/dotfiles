return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
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
          ["<CR>"] = {
            i = cmp.mapping.confirm({ select = true }),
          },
        }),
        sources = {
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
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
    end
  },
}
