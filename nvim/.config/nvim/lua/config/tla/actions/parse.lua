local Job = require("plenary.job")
local utils = require('config.tla.utils')
local config = require('config.tla.config')
local Table = require('config.utils.table')

return function()
  local tla_file_path = utils.current_filepath()
  if not utils.is_tla_file(tla_file_path) then
    vim.notify("[TLA] Can only run on .tla files", vim.log.levels.ERROR)
    return
  end

  local command = config.java_executable

  local args = {
    "-cp",
    config.tla2tools,
    "pcal.trans",
    "-nocfg",
    tla_file_path,
  }

  local logs = {}
  local on_result = vim.schedule_wrap(function(err, output)
    if err then
      Table.push(logs, err)
    elseif output then
      Table.push(logs, output)
    end
  end)

  Job
      :new({
        command = command,
        args = args,
        on_stdout = on_result,
        on_error = on_result,
        on_exit = vim.schedule_wrap(function(self, code, signal)
          if code == 0 then
            vim.notify(table.concat(logs, "\n"))
          else
            vim.notify(table.concat(logs, "\n"), vim.log.levels.ERROR)
          end
          vim.cmd("edit! " .. tla_file_path)
        end)
      })
      :start()
end
