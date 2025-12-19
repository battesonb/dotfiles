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
        ["<Tab>"] = {
          function()
            local ls = require("luasnip")
            if ls.expand_or_jumpable() then
              ls.jump(1)
              return true
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function()
            local ls = require("luasnip")
            if ls.expand_or_jumpable() then
              ls.jump(-1)
              return true
            end
          end,
          "fallback",
        },
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
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer" },
        providers = {
          lsp = {
            async = true,
            timeout_ms = 200,
          },
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    }
  },
}
