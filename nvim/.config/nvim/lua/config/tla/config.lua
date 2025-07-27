---@class TlaGeneratePdfConfig
---@field number boolean Whether to produce line numbers in the left margin (default: false).
---@field shade boolean Causes comments to be shaded (default: true).
---@field no_pcal_shade boolean When the -shade option is chosen, this option causes a PlusCal algorithm (which appear in a comment) not to be shaded. The algorithm's comments will be shaded (default: true).
---@field gray_level number Determines darkness of comment shading, where 0 = black, 1 = white (default 0.85).

---@class TlaConfig
---@field java_executable string Path to Java executable.
---@field tla2tools string Path to the tla2tools.jar file.
---@field java_opts table Optional Java args.
---@field pdf_config TlaGeneratePdfConfig

-- The runtime defaults are configured in tla#setup({...})
---@type TlaConfig
local config = {
  pdf_config = {
    number = false,
    shade = true,
    no_pcal_shade = true,
    gray_level = 0.85,
  }
}

return config
