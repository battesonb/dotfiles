vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight copied text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = "Conditionally disable spell check",
  group = vim.api.nvim_create_augroup("spell-check-disable", { clear = true }),
  callback = function()
    if vim.o.buftype == "terminal" then
      vim.o.spell = false
    end
  end
})

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
      vim.keymap.set("n", "<leader>cx", ":!" .. command .. " %<CR>", { buffer = true })
      vim.keymap.set({ "n", "v" }, "<leader>x", ":.w !" .. command .. "<CR>", { buffer = true })
      vim.keymap.set("n", "<leader><leader>x", function()
        vim.notify("Cannot source file, only Lua supported", vim.log.levels.ERROR)
      end, { buffer = true })
    elseif vim.o.filetype == "lua" then
      vim.keymap.set("n", "<leader>cx", ":!lua %<CR>", { buffer = true })
      vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { buffer = true })
      vim.keymap.set("n", "<leader>x", ":.lua<CR>", { buffer = true })
      vim.keymap.set("v", "<leader>x", ":lua<CR>", { buffer = true })
    else
      vim.keymap.set("n", "<leader>cx", function()
        vim.notify("Cannot execute file", vim.log.levels.ERROR)
      end, { buffer = true })
      vim.keymap.set("n", "<leader><leader>x", function()
        vim.notify("Cannot source file, only Lua supported", vim.log.levels.ERROR)
      end, { buffer = true })
      vim.keymap.set("n", "<leader>x", function()
        vim.notify("Cannot execute line", vim.log.levels.ERROR)
      end, { buffer = true })
      vim.keymap.set("v", "<leader>x", function()
        vim.notify("Cannot execute selection", vim.log.levels.ERROR)
      end, { buffer = true })
    end
  end
})
