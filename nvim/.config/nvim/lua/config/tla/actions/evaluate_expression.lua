local Job = require("plenary.job")
local Table = require("config.utils.table")
local strings = require("config.utils.strings")
local config = require('config.tla.config')

---@param selection string[]
return function(selection)
  local expression = vim.fn.input("Expression: ", #selection == 0 and "" or selection[1])
  expression = strings.trim(expression)

  if #expression == 0 then
    return
  end

  local command = config.java_executable
  local args = {
    "-cp",
    config.tla2tools,
    "tlc2.REPL",
    expression,
  }

  local logs = {}
  local on_result = vim.schedule_wrap(function(err, output)
    if err then
      Table.push(logs, err)
    end
    if output then
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
          local level = code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
          vim.notify(table.concat(logs, "\n"), level)
        end)
      })
      :start()
end
