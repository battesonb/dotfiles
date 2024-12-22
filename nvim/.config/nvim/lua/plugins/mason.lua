return {
  {
    "williamboman/mason.nvim",
    priority = 200,
    config = function()
      require('mason').setup({})
    end
  },
}
