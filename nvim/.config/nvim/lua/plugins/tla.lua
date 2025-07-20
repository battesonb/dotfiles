return {
  "susliko/tla.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("tla").setup()
  end
}
