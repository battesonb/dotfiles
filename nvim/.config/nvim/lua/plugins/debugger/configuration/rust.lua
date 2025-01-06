---@class cargo.CompilerEvent
---@field reason "compiler-artifact"
---@field executable string | nil

--- Parses cargo metadata. The type is the absolute minimum needed for this configuration.
---@return cargo.CompilerEvent[]
local function parse_cargo_metadata(output)
  local metadata = {}
  for _, line in ipairs(output) do
    local trimmed = vim.trim(line)
    if string.len(trimmed) ~= 0 then
      local parsed = vim.fn.json_decode(trimmed)
      table.insert(metadata, parsed)
    end
  end

  return metadata
end

---@class TestCommandConfig
---@field cwd string

---Generates the test binary for the current working directory and returns the path.
---@param config TestCommandConfig
---@return string
local function test_command(config)
  local compiler_msg_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_var(compiler_msg_buf, "buftype", "nofile")

  local width = 50
  local height = 12

  local compiler_msg_window = vim.api.nvim_open_win(compiler_msg_buf, false, {
    relative = "editor",
    width = width,
    height = height,
    col = vim.go.columns - width - 1,
    row = vim.go.lines - height - 1,
    border = "rounded",
    style = "minimal",
  })

  local compiler_output = {}
  local status_code = -1
  local cargo_job = vim.fn.jobstart("cargo test --message-format json --no-run", {
    clear_env = false,
    cwd = config.cwd,
    stdout_buffered = true,
    on_stdout = function(_, data)
      compiler_output = data
    end,
    on_stderr = function(_, data)
      if vim.api.nvim_buf_is_valid(compiler_msg_buf) then
        vim.fn.appendbufline(compiler_msg_buf, vim.fn.line("$", compiler_msg_window), data)
        vim.cmd("redraw")
      end
    end,
    on_exit = function(_, exit_code)
      if vim.api.nvim_win_is_valid(compiler_msg_window) then
        vim.api.nvim_win_close(compiler_msg_window, true)
      end

      if vim.api.nvim_buf_is_valid(compiler_msg_buf) then
        vim.api.nvim_buf_delete(compiler_msg_buf,{ force = true })
      end

      status_code = exit_code
      if exit_code == 0 then
        compiler_output = parse_cargo_metadata(compiler_output)
      end
    end,
  })

  vim.fn.jobwait({ cargo_job })

  if status_code ~= 0 then
    vim.notify("Failed to build cargo test binary", vim.log.levels.ERROR)
    return ""
  end

  ---@type cargo.CompilerEvent
  local artifact = vim.iter(compiler_output):filter(function(event)
    return event.reason == "compiler-artifact"
  end):last()

  print(artifact.executable)
  return artifact.executable
end

--- A best-effort attempt at narrowing down the tests so that breakpoints are
--- hit earlier. If not, the entire test binary is run.
---@return string[]
local function test_args()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return {}
  end

  ---@type TSNode?
  local expr = current_node
  while expr do
    if expr:type() == "function_item" then
      break
    end

    expr = expr:parent()
  end

  if not expr then
    return {}
  end

  local test_name = vim.treesitter.get_node_text(expr:child(1), vim.api.nvim_get_current_buf())[1]
  return { test_name }
end

return {
  setup = function()
    require('dap').configurations.rust = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Test (All)",
        type = "codelldb",
        request = "launch",
        program = function()
          return test_command({
            cwd = vim.fn.getcwd(),
          })
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Test (Current)",
        type = "codelldb",
        request = "launch",
        program = function()
          return test_command({
            cwd = vim.fn.getcwd(),
          })
        end,
        args = function()
          return test_args()
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      }
    }
  end,
}

