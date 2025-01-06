local M = {}

--- Opens a telescope picker for untracked and modified files in the current working tree.
local git_diff_files = function(opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require('telescope.config').values

  local list = vim.fn.systemlist("git ls-files --others --modified --exclude-standard")

  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Git diff files",
    finder = finders.new_table({
      results = list,
    }),
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>fd", git_diff_files)
end

return M
