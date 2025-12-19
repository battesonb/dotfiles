return {
  'ggml-org/llama.vim',
  init = function()
    vim.g.llama_config = {
      enable_at_startup = false,
      show_info = false,
    }
  end,
}
