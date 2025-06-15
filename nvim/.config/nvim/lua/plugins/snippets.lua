return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    init = function()
      local ls = require("luasnip")
      local lua = require("luasnip.loaders.from_lua")

      ls.setup({
        enable_autosnippets = true,
      })

      ls.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

      lua.load({ paths = { vim.fn.stdpath("config") .. "/snippets/" } })

      vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end)
      vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end)
      vim.keymap.set({ "i", "s" }, "<C-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
      vim.keymap.set({ "i", "s" }, "<C-p>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end)
    end
  },
  {
    "danymat/neogen",
    config = function()
      local neogen = require('neogen')
      neogen.setup({ snippet_engine = "luasnip" })

      vim.keymap.set("n", "<Leader>ck", function() neogen.generate() end,
        { noremap = true, silent = true })
    end
  },
}
