return {
  "olimorris/codecompanion.nvim",
  config = function()
    local codecompanion = require("codecompanion")

    vim.keymap.set({ "n", "v" }, "<leader>ai", codecompanion.actions, { desc = "AI actions" })

    codecompanion.setup({
      adapters = require("plugins.codecompanion.adapters"),
      prompt_library = require("plugins.codecompanion.prompts"),
      strategies = {
        cmd = { adapter = "qwen", },
        chat = { adapter = "qwen", },
        inline = { adapter = "qwen", },
      },
      opts = {
        log_level = "TRACE",
      },
    })
  end,
}
