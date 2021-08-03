function git_status() {
    local git_branch=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
    local git_status=$(git status 2> /dev/null)
    local git_root=$(basename `git rev-parse --show-toplevel`)

    local git_color="green"

    # Determine color
    if [[ ! $git_status =~ "working tree clean" ]]; then
        git_color="red"
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        git_color="yellow"
    fi

    # Prepare text
    if [[ ! -z $git_branch ]]; then
        echo "%F{240}git[%f$git_root:%F{$git_color}$git_branch%f%F{240}]%f"
    fi
}

setopt PROMPT_SUBST
RPROMPT='$(git_status)'
PROMPT='%(?.%F{green}✓.%F{red}[%?])%f %F{cyan}%1~%f $ '
