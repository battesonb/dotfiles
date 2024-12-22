if vim.fn.has("win32") ~= 0 or vim.fn.has("win64") ~= 0 then
  vim.keymap.set({ "n", "v" }, "<C-z>", function()
    vim.api.nvim_err_writeln("Suspend is not available on Windows")
  end)
end
