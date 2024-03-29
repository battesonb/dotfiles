local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']g', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

if not configs.wgsl_analyzer then
  configs.wgsl_analyzer = {
    default_config = {
      cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/wgsl_analyzer" },
      filetypes = { "wgsl" },
      root_dir = lspconfig.util.root_pattern(".git", "wgsl"),
      settings = {},
    }
  }
end

lspconfig.wgsl_analyzer.setup({
  on_attach = on_attach
})

if not configs.smithy_ls then
  configs.smithy_ls = {
    default_config = {
      cmd = { vim.fn.expand("$HOME") .. "/smithy/bin/smithy-language-server", "0" },
      filetypes = { "smithy" },
      root_dir = lspconfig.util.root_pattern("smithy-build.json", "build.gradle", "build.gradle.kts", "build.xml", ".git"),
      single_file_support = true,
      message_level = vim.lsp.protocol.MessageType.Log,
      init_options = {
        statusBarProvider = "show-message",
        isHttpEnabled = true,
        compilerOptions = {
          snippetAutoIndent = false,
        },
      },
      settings = {},
    }
  }
end

lspconfig.smithy_ls.setup({
  on_attach = on_attach
})

lspconfig.hls.setup({
  on_attach = on_attach,
  filetypes = { "haskell", "hs", "lhaskell", "cabal" }
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("lua", true)
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
