-- These all require the inclusion of a `require('debug')` line for the debugger
-- to work. This shouldn't be necessary, but it works for now.
return {
  setup = function()
    require('dap').configurations.ruby = {
      {
        type = "ruby",
        name = "Debug current file",
        request = "launch",
        localfs = true,
        command = "ruby",
        script = "${relativeFile}",
        cwd = "${workspaceFolder}"
      },
      {
        type = "ruby",
        name = "Run current spec file",
        request = "launch",
        localfs = true,
        command = "rspec",
        script = "${relativeFile}",
        cwd = "${workspaceFolder}"
      },
    }
  end,
}
