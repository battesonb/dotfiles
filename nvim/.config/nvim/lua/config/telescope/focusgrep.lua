local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require('telescope.config').values

local M = {}

local file_ignore_patterns = {
  "node_modules",
  ".git",
  "*.lock",
  "*-lock.json*"
}

local focus_live_grep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      else
        return nil
      end

      for _, pattern in ipairs(file_ignore_patterns) do
        table.insert(args, "-g")
        table.insert(args, "!" .. pattern)
      end

      if pieces[2] then
        local file_globs = vim.split(pieces[2], ",")
        for _, file_glob in ipairs(file_globs) do
          table.insert(args, "-g")
          table.insert(args, file_glob)
        end
      end

      return vim.iter({
        args,
        {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        }
      }):flatten(1):totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Focus live grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>fg", focus_live_grep)
end

return M
