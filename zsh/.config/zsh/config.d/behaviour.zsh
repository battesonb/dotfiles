# Emacs editing mode, I use tmux for vi bindings.
bindkey -e

# Emacs/Readline compatibility
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^R' history-incremental-search-backward

export EDITOR=nvim
export MANPAGER='nvim +Man!'
