local Job = require("plenary.job")
local Path = require("plenary.path")
local utils = require('config.tla.utils')
local config = require('config.tla.config')

return function()
  local file_path = utils.current_filepath()
  if not utils.is_tla_file(file_path) and not utils.is_cfg_file(file_path) then
    vim.notify("[TLA] Can only run on .tla or .cfg files", vim.log.levels.ERROR)
    return
  end

  local command = config.java_executable

  local tla_file_path = file_path:gsub("%....$", "") .. ".tla"
  local cfg_file_path = file_path:gsub("%....$", "") .. ".cfg"

  local args = {
    "-cp",
    config.tla2tools,
    "tlc2.TLC",
    "-dumpTrace",
    "json",
    "trace.json",
    "-config",
    cfg_file_path,
    tla_file_path,
  }

  local bufnr = utils.output_buf()
  utils.open_window(bufnr)
  utils.clear_buf(bufnr)

  local on_result = vim.schedule_wrap(function(err, output)
    if err then
      utils.append_to_buf(bufnr, { err })
    end
    if output then
      utils.append_to_buf(bufnr, { output })
    end
  end)

  local parent_dir = Path:new(tla_file_path):parent().filename
  Job
      :new({
        command = command,
        args = args,
        cwd = parent_dir,
        on_stdout = on_result,
        on_error = on_result,
      })
      :start()
end
