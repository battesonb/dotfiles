return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        -- Let LuaSnip control this
        ["<Tab>"] = false,
        ["<S-Tab>"] = false,
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        list = {
          selection = {
            preselect = function()
              return not require("blink.cmp").snippet_active()
            end,
          },
        },
      },
      signature = { enabled = true },
      snippets = {
        preset = "luasnip",
        should_show_items = function()
          return not require("blink.cmp").snippet_active()
        end,
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    }
  },
}
