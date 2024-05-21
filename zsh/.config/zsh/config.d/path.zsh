# Responsible for amending the environment path variable with required paths

export EDITOR=nvim

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Dart-related paths
export PATH="/usr/lib/dart/bin:$PATH"

# Rust-related paths
export PATH="$HOME/.cargo/bin:$PATH"

# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# rbenv
if command -v rbenv; then
  eval "$(rbenv init - zsh)"
fi

# Prepare nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Prepare pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Export sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Skim (only on Mac)
case `uname` in
  Darwin)
    alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
  ;;
esac
