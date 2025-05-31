vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight copied text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Set filetype from shebang",
  group = vim.api.nvim_create_augroup("filetype-shebang", { clear = true }),
  callback = function()
    local first_line = vim.fn.getline(1)
    local filetype = first_line:match("^#!.* (%w+)")
    if not filetype then
      filetype = first_line:match("^#!.*/(%w+)")
    end
    if filetype then
      vim.bo.filetype = filetype
    end
  end,
})

-- This does not configure Lua as it is supported in-editor. See after/ftplugin/lua.lua for that
-- configuration.
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = "Set scripting language keymap",
  group = vim.api.nvim_create_augroup("scripting-keymap", { clear = true }),
  callback = function()
    local commands = {
      bash = "bash",
      sh = "bash",
      javascript = "node",
      python = "python",
      ruby = "ruby",
    }
    local command = commands[vim.o.filetype]
    if command then
      vim.keymap.set("n", "<leader>cx", ":!" .. command .. " %<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>x", ":.w !" .. command .. "<CR>")
    end
  end
})
