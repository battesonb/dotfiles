return {
  {
    "echasnovski/mini.nvim",
    opts = {
      modules = {
        ["mini.align"] = {},
        ["mini.icons"] = {},
        ["mini.statusline"] = {},
      },
    },
    config = function(_, opts)
      for module, descriptor in pairs(opts.modules) do
        local config = descriptor["config"] or {}
        local setup = descriptor["setup"]
        require(module).setup(config)

        if setup then
          setup(config)
        end
      end
    end
  },
}
