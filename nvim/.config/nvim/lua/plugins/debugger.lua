return {
  {
    "mfussenegger/nvim-dap",
    priority = 250,
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          "williamboman/mason.nvim",
        },
        config = function()
          require("mason-nvim-dap").setup({
            ensure_installed = {
              "bash-debug-adapter",
              "codelldb",
              "delve",
              "ruby",
            },
          })
        end
      },
    },
    opts = {
      configs = {
        ["dap-go"] = {},
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local ui = require("dapui")

      ui.setup()

      for key, config in pairs(opts.configs) do
        require(key).setup(config)
      end

      -- Adapters
      require("plugins.debugger.adapter.bashdb").setup()
      require("plugins.debugger.adapter.codelldb").setup()
      require("plugins.debugger.adapter.ruby").setup()

      -- Configurations
      require("plugins.debugger.configuration.bash").setup()
      require("plugins.debugger.configuration.c").setup()
      require("plugins.debugger.configuration.ruby").setup()
      require("plugins.debugger.configuration.rust").setup()

      vim.api.nvim_create_user_command("DapWatch", function()
        ui.elements.watches.add(vim.fn.input("Expression: ", "", "expression"))
      end, {})

      vim.keymap.set("n", "<leader>dd", dap.continue)
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints)
      vim.keymap.set("n", "<leader>dh", dap.run_to_cursor)
      vim.keymap.set("n", "<leader>dw", function()
        local to_watch = vim.fn.expand("<cword>")
        for i, watched in ipairs(ui.elements.watches.get()) do
          print(watched.expression .. " == " .. to_watch)
          if watched.expression == to_watch then
            ui.elements.watches.remove(i)
            return
          end
        end
        ui.elements.watches.add(to_watch)
      end)
      vim.keymap.set("n", "<leader>de", function()
        ui.eval(nil, { enter = true })
      end)
      vim.keymap.set("n", "<leader>dr", dap.restart)
      vim.keymap.set("n", "<leader>dx", function()
        ui.close()
        dap.close()
      end)
      vim.keymap.set("n", "<leader>dh", dap.step_back)
      vim.keymap.set("n", "<leader>dj", dap.step_into)
      vim.keymap.set("n", "<leader>dk", dap.step_out)
      vim.keymap.set("n", "<leader>dl", dap.step_over)

      local event_config = {
        open = { "attach", "launch" },
        close = { "event_terminated", "event_exited" },
      }
      for action, events in pairs(event_config) do
        for _, event in ipairs(events) do
          dap.listeners.before[event].dapui_config = function()
            ui[action]()
          end
        end
      end
    end
  },
}
