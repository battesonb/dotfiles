local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local tla_actions = require('config.tla.actions')
local Table = require("config.utils.table")
local utils = require('config.tla.utils')

local function picker(opts)
  local visual_selection = utils.get_visual_selection()

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "TLA Actions",
    finder = finders.new_table {
      results = Table.keys(tla_actions)
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        tla_actions[selection[1]](visual_selection)
      end)
      return true
    end,
  }):find()
end

return picker
