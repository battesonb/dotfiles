# Responsible for amending the environment path variable with required paths

export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/lib/dart/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# rbenv
if command -v rbenv >/dev/null 2>&1; then
  function rbenv {
    unset -f rbenv
    eval "$(rbenv init - zsh)"
    rbenv "$@"
  }
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; nvm $@"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  function pyenv {
    unset -f pyenv
    eval "$(pyenv init -)"
    pyenv "$@"
  }
fi

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Skim (only on Mac)
case `uname` in
  Darwin)
    alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
  ;;
esac
