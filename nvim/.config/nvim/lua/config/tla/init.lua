Config = require('config.tla.config')
local Path = require("plenary.path")
local utils = require('config.tla.utils')

local M = {}

M.setup = function(user_config)
  user_config = user_config or {}

  if user_config["java_executable"] then
    Config.java_executable = Path:new(user_config["java_executable"]).filename
  else
    Config.java_executable = utils.default_java_executable()
  end

  Config.java_opts = user_config["java_opts"] or { "-XX:+UseParallelGC" }
  if user_config["tla2tools"] then
    Config.tla2tools = Path:new(user_config["tla2tools"]).filename
  else
    Config.tla2tools = Path:new(utils.tla_nvim_cache_dir, "tla2tools.jar").filename
  end

  if not Path:new(Config.tla2tools):exists() then
    utils.install_tla2tools()
  end

  Config = Config
end

M.picker = require('config.tla.picker')
M.evaluate_expression = function()
  local visual_selection = utils.get_visual_selection()
  require('config.tla.actions.evaluate_expression')(visual_selection)
end

return M
