autoload -U edit-command-line
zle -N edit-command-line
bindkey -e
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^R' history-incremental-search-backward
