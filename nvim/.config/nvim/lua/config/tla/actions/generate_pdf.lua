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
    "tla2tex.TLA",
    "-nops",
    "-grayLevel",
    config.pdf_config.gray_level,
  }
  if config.pdf_config.number then
    Table.push(args, "-number")
  end
  if config.pdf_config.shade then
    Table.push(args, "-shade")
  end
  if config.pdf_config.no_pcal_shade then
    Table.push(args, "-noPcalShade")
  end
  Table.push(args, tla_file_path)

  local logs = {}
  local on_result = vim.schedule_wrap(function(err, output)
    if err then
      Table.push(logs, err)
    end
    if output then
      Table.push(logs, output)
    end
  end)

  local tex_gen_job = Job
      :new({
        command = command,
        args = args,
        on_stdout = on_result,
        on_error = on_result,
        on_exit = vim.schedule_wrap(function(self, code, signal)
          if code ~= 0 then
            vim.notify(table.concat(logs, "\n"), vim.log.levels.ERROR)
          end
        end)
      })

  local tex_file_path = tla_file_path:gsub(".tla$", "") .. ".tex"
  tex_gen_job:and_then_on_success(Job:new({
    command = "pdflatex",
    args = {
      tex_file_path,
    },
    on_stdout = on_result,
    on_error = on_result,
    on_exit = vim.schedule_wrap(function(self, code, signal)
      if code == 0 then
        vim.notify(table.concat(logs, "\n"))
      else
        vim.notify(table.concat(logs, "\n"), vim.log.levels.ERROR)
      end
    end)
  }))
  tex_gen_job:start()
end
