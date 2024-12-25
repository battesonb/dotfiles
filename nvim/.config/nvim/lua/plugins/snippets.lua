return {
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

      vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end)
      vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end)
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end
  },
  {
    'mireq/luasnip-snippets',
    dependencies = { 'L3MON4D3/LuaSnip' },
    build = "make install_jsregexp",
    init = function()
      -- Mandatory setup function
      require('luasnip_snippets.common.snip_utils').setup()
    end
  },
}
