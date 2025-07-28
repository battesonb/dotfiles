local Curl = require("plenary.curl")
local Path = require("plenary.path")

local M = {}

M.current_filepath = function()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_name(bufnr)
end

M.tla_nvim_cache_dir = Path.new(vim.fn.stdpath("cache"), "tla.nvim")

---@param filepath string
---@param file_type string
---@return boolean
M.is_filetype = function(filepath, file_type)
  return filepath:match("%.([^%.]*)$") == file_type
end

---@param filepath string
---@return boolean
M.is_tla_file = function(filepath)
  return M.is_filetype(filepath, "tla")
end

---@param filepath string
---@return boolean
M.is_cfg_file = function(filepath)
  return M.is_filetype(filepath, "cfg")
end

local output_bufnr
-- Returns the buffer number for the output buffer. Creates a new buffer if it does not exist.
---@return number
M.output_buf = function()
  if not output_bufnr or not vim.api.nvim_buf_is_valid(output_bufnr) then
    output_bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(output_bufnr, "TLA Check Output")
    vim.bo[output_bufnr].buftype = "nofile"
    vim.bo[output_bufnr].bufhidden = "wipe"
  end
  return output_bufnr
end

M.open_window = function(bufnr)
  local output_wins = vim.fn.win_findbuf(bufnr)
  if #output_wins == 0 then
    vim.api.nvim_command("vsp")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, bufnr)
    vim.api.nvim_command("wincmd p")
  end
end

---@param bufnr number
---@param lines string[]
M.append_to_buf = function(bufnr, lines)
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local windows = vim.fn.win_findbuf(bufnr)
  for _, window in pairs(windows) do
    vim.api.nvim_win_set_cursor(window, { line_count, 0 })
  end
end

M.clear_buf = function(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
end

---@return string[]
M.get_visual_selection = function()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    return {}
  end
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")

  if mode == "V" then
    local start_line = vim.fn.strlen(vim.fn.getline(start_pos[2]))
    local end_line = vim.fn.strlen(vim.fn.getline(end_pos[2]))
    start_pos[3] = start_pos[2] <= end_pos[2] and 1 or start_line
    end_pos[3] = end_pos[2] < start_pos[2] and 1 or end_line
  end

  return vim.fn.getregion(start_pos, end_pos)
end

---@return string?
M.default_java_executable = function()
  local java_home = vim.fn.getenv("JAVA_HOME")
  if java_home ~= vim.NIL then
    return Path:new(java_home, "bin", "java").filename
  else
    vim.notify("[TLA] Either 'java_executable' config or 'JAVA_HOME' environment variable must be set",
      vim.log.levels.WARN)
    return nil
  end
end

M.install_tla2tools = function()
  local release_url = "https://api.github.com/repos/tlaplus/tlaplus/releases/latest"
  local release_page = vim.fn.json_decode(Curl.get(release_url).body)
  local asset = vim.iter(release_page.assets):find(function(value)
    return value["name"] == "tla2tools.jar"
  end)
  if asset then
    if not M.tla_nvim_cache_dir:exists() then
      M.tla_nvim_cache_dir:mkdir()
    end
    local download_url = asset["browser_download_url"]
    local output_filename = Path:new(M.tla_nvim_cache_dir, "tla2tools.jar").filename
    Curl.get(download_url, { output = output_filename })
    vim.notify("[TLA] Downloaded tla2tools " .. release_page.tag_name)
  end
end

return M
