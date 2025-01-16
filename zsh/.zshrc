# Load separate config files
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done

[[ -f ~/.zsh_overrides ]] && source ~/.zsh_overrides

local syntax_higlighting="$HOME/.config/zsh/plugins.d/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$syntax_higlighting" ]; then
  source "$syntax_higlighting"
fi

