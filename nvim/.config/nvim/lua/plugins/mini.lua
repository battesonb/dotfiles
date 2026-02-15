return {
  {
    "echasnovski/mini.nvim",
    opts = {
      modules = {
        ["mini.align"] = {},
        ["mini.icons"] = {},
        ["mini.statusline"] = {},
        ["mini.pairs"] = {
          config = {
            by_filetype = {
              rust = {
                mappings = {
                  ["'"] = false,
                },
              },
            },
          },
          setup = function(config)
            local minipairs = require("mini.pairs")
            local base_mappings = minipairs.config.mappings
            local by_filetype = config.by_filetype

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
              desc = "mini.pairs custom config",
              group = vim.api.nvim_create_augroup("mini-pairs-custom-config", { clear = true }),
              callback = function()
                local filetype_config = by_filetype[vim.bo.filetype]
                if filetype_config then
                  for key, value in pairs(filetype_config.mappings) do
                    if value == false then
                        minipairs.unmap("i", key, key .. key)
                    else
                      local pair_info = value or base_mappings[key]
                      minipairs.map("i", key, pair_info)
                    end
                  end
                end
              end
            })
          end,
        },
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
