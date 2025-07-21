local function init()
  if not vim.g.vscode then
    return
  end

  local vscode = require("vscode")

  local function vscode_action(name)
    return function()
      vscode.action(name)
    end
  end

  vim.keymap.set("n", "[g", vscode_action("editor.action.marker.prev"))
  vim.keymap.set("n", "]g", vscode_action("editor.action.marker.next"))
  vim.keymap.set("n", "gd", vscode_action("editor.action.revealDefinition"))
  vim.keymap.set("n", "gi", vscode_action("editor.action.goToImplementation"))
  vim.keymap.set("n", "gr", vscode_action("editor.action.goToReferences"))
  vim.keymap.set("n", "gy", vscode_action("editor.action.goToTypeDefinition"))
  vim.keymap.set({ "n", "i" }, "<C-y>", vscode_action("editor.action.accessibleViewAcceptInlineCompletion"))
  vim.keymap.set("n", "K", vscode_action("editor.action.triggerSuggest"))
  vim.keymap.set("n", "<leader>ca", vscode_action("editor.action.quickFix"))
  vim.keymap.set({ "n", "v" }, "<leader>cc", vscode_action("editor.action.commentLine"))
  vim.keymap.set("n", "<leader>rn", vscode_action("editor.action.rename"))
  vim.keymap.set("n", "<leader>rf", vscode_action("editor.action.formatDocument"))
  vim.keymap.set("n", "<leader>fg", vscode_action("workbench.view.search"))
  vim.keymap.set("n", "<leader>ff", vscode_action("workbench.action.quickOpen"))
end

init()
