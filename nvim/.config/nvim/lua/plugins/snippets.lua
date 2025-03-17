return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = { 'rafamadriz/friendly-snippets' },
    build = "make install_jsregexp",
    init = function()
      local ls = require("luasnip")
      local lua = require("luasnip.loaders.from_lua")
      require("luasnip.loaders.from_vscode").lazy_load()

      ls.setup({
        enable_autosnippets = true,
      })

      ls.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

      lua.load({ paths = { vim.fn.stdpath("config") .. "/snippets/" } })

      vim.keymap.set({ "i", "s" }, "<C-j>", function() ls.jump(1) end)
      vim.keymap.set({ "i", "s" }, "<C-k>", function() ls.jump(-1) end)
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        else
          local keys = vim.api.nvim_replace_termcodes("<C-g>u<Esc>[s1z=`]a<C-g>u", true, false, true)
          vim.api.nvim_feedkeys(keys, "n", false)
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
