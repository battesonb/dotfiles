---@class (exact) codecompanion.PromptLibraryConfig
---@field strategy "chat" | "inline" | "workflow"
---@field description string
---@field opts codecompanion.PromptLibraryConfigOpts
---@field prompts table<codecompanion.PromptLibraryConfigPrompt>

---@class (exact) codecompanion.PromptLibraryConfigOpts
---@field index? number
---@field is_default? boolean
---@field is_slash_cmd? boolean
---@field modes? table<string>
---@field short_name? string
---@field auto_submit? boolean
---@field user_prompt? boolean
---@field stop_context_insertion? boolean

---@class (exact) PromptLibraryConfigPrompt
---@field role "system" | "user"
---@field content string
---@field opts? codecompanion.PromptLibraryConfigPromptOpts

---@class (exact) codecompanion.PromptLibraryConfigPromptOpts
---@field visible? boolean
---@field contains_code? boolean
