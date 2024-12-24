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
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-p>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ["<C-n>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
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
        },
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
