---@class RubyAdapterConfig
---@field command string
---@field cwd string
---@field script string

return {
  setup = function()
    ---@param callback fun(config: table)
    ---@param config RubyAdapterConfig
    require('dap').adapters.ruby = function(callback, config)
      callback({
        type = "server",
        port = "${port}",
        executable = {
          command = "bundle",
          args = {
            "exec", "rdbg", "--open", "--port", "${port}", "-c", "--",
            "bundle", "exec", config.command, config.script,
          },
          detached = false,
          cwd = config.cwd,
        },
      })
    end
  end,
}
