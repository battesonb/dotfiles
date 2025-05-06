return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = 'maia'
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("sonokai")
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup({
        "css",
        "javascript",
        "html",
      })
    end
  },
}
