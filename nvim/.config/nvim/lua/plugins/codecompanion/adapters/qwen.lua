return function()
  local overrides = {
    name = "qwen",
    schema = {
      model = {
        -- Largest model I can run locally without offloading into RAM for slow CPU inference :'(
        default = "qwen2.5-coder:7b",
      },
    },
  }
  return require("codecompanion.adapters").extend("ollama", overrides)
end
