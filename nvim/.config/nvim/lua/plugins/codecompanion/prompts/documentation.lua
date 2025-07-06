---@module 'codecompanion'
---@type codecompanion.PromptLibraryConfig
return {
  strategy = "inline",
  description = "Add documentation to selected code",
  opts = {
    index = 11,
    is_default = true,
    is_slash_cmd = true,
    modes = { "v" },
    short_name = "doc",
    auto_submit = true,
    user_prompt = false,
    stop_context_insertion = true,
  },
  prompts = {
    {
      role = "system",
      content = [[
When asked to add documentation, follow these steps:
1. **Identify Key Points**: Carefully read the provided code to understand its functionality.
2. **Plan the Documentation**: Describe the key points to be documented in pseudocode, detailing each step. The documentation must:
  - Includes only necessary explanations, limit inline comments for trivial changes.
  - Add parameters, return values, and exceptions documentation.
  - Follows best practices for readability and maintainability.
  - Is formatted correctly.
3. **Implement the Documentation**: Write the accompanying documentation in the same file or a separate file. Do not follow this implementation with anything else.

Use Markdown formatting and include the programming language name at the start of the code block.]],
      opts = {
        visible = true
      },
    },
    {
      role = "user",
      content = function(ctx)
        local code = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
        return string.format("Please document the selected code:\n\n```%s\n%s\n```\n\n", ctx.filetype, code)
      end,
      opts = {
        contains_code = true,
      },
    },
  },
}
