# Load separate config files
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done

[[ -f ~/.zsh_overrides ]] && source ~/.zsh_overrides
