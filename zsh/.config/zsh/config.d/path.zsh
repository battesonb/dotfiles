# Responsible for amending the environment path variable with required paths

export EDITOR=nvim

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/lib/dart/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Haskell (ghcup)
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Skim (only on Mac)
case `uname` in
  Darwin)
    alias skim='/Applications/Skim.app/Contents/MacOS/Skim'
  ;;
esac

# Linux Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export PATH="$PATH:/opt/nvim-linux64/bin"
fi

# Activate mise, if present
if [ -f "/usr/bin/mise" ]; then
  eval "$(/usr/bin/mise activate bash)"
fi
