return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    init = function()
      local ls = require("luasnip")
      local lua = require("luasnip.loaders.from_lua")

      local extensions = {
        wiki = "xwiki",
      }

      ls.setup({
        enable_autosnippets = true,
        history = true,
        updateevents = "TextChanged,TextChangedI",
        ft_func = function()
          local name = vim.api.nvim_buf_get_name(0)
          local pieces = vim.split(name, '/')
          name = pieces[#pieces]
          local exts = vim.split(name, '.', { plain = true })
          table.remove(exts, 1)
          local filetypes = vim.list_extend(vim.split(vim.bo.filetype, ".", { plain = true }), exts)
          for key, value in pairs(extensions) do
            if vim.tbl_contains(filetypes, key) then
              vim.list_extend(filetypes, { value })
            end
          end
          return filetypes
        end
      })

      lua.load({ paths = { vim.fn.stdpath("config") .. "/snippets/" } })

      vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end)
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end)
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
