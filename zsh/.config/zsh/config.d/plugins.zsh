local plugin_path="$HOME/.config/zsh/plugins.d/"

if [ -f "$plugin_path/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$plugin_path/zsh-autosuggestions/zsh-autosuggestions.zsh"
  bindkey '^Y' autosuggest-accept
fi

