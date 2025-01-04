local M = {}

--- Returns a list of project features under the local `RUST_LSP_FEATURES` environment variable.
---@return string[]
M.project_features = function()
  local project_features_env = os.getenv("RUST_LSP_FEATURES") or ""
  local features = vim.split(project_features_env, ",")
  return vim.iter(features):filter(function(f)
    return f ~= ""
  end):totable()
end

return M
