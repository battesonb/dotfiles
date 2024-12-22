return {
  {
    "echasnovski/mini.nvim",
    opts = {
      modules = {
        ["mini.align"] = {},
        ["mini.icons"] = {},
        ["mini.statusline"] = {},
        ["mini.surround"] = {},
      },
    },
    config = function(_, opts)
      for module, config in pairs(opts.modules) do
        require(module).setup(config)
      end
    end
  },
}
