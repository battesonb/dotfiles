return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.config")
      config.setup({
        modules = {},
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").p = {
            install_info = {
              url = "https://github.com/battesonb/tree-sitter-p",
              branch = "main",
              files = { "src/parser.c" },
              queries = 'queries',
            },
            filetype = "p",
          }
        end
      })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99

      vim.api.nvim_set_hl(0, "@error", { bg = "#8f4747", bold = true, undercurl = true })

      local function goto_error(bufnr, direction)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local cursor_row = cursor[1] - 1
        local cursor_col = cursor[2]

        local parser = vim.treesitter.get_parser(bufnr)
        if not parser then
          return
        end
        local result = nil

        parser:for_each_tree(function(tstree)
          local function walk(node)
            if node:type() == "ERROR" then
              local start_row, start_col = node:start()
              local is_candidate = direction == "forward"
                  and (start_row > cursor_row or (start_row == cursor_row and start_col > cursor_col))
                  or (start_row < cursor_row or (start_row == cursor_row and start_col < cursor_col))

              if is_candidate then
                if result == nil then
                  result = node
                else
                  local rr, rc = result:start()
                  local closer = direction == "forward"
                      and (start_row < rr or (start_row == rr and start_col < rc))
                      or (start_row > rr or (start_row == rr and start_col > rc))
                  if closer then result = node end
                end
              end
            end
            for child in node:iter_children() do walk(child) end
          end
          walk(tstree:root())
        end)

        if result then
          local row, col = result:start()
          vim.api.nvim_win_set_cursor(0, { row + 1, col })
        end
        return result and vim.treesitter.get_node_text(result, bufnr) or "No TS error"
      end

      -- Keymaps
      vim.keymap.set("n", "]e", function() print(goto_error(nil, "forward")) end)
      vim.keymap.set("n", "[e", function() print(goto_error(nil, "backward")) end)
    end
  },
  "nvim-treesitter/nvim-treesitter-context",
}
