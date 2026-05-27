# Responsible for making the prompt look pretty!

function git_statusline() {
    local git_branch=$(git branch --show-current 2> /dev/null)
    if [[ -z $git_branch ]]; then
        return
    fi

    local git_status=$(git status 2> /dev/null)
    local git_root=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
    local git_color="green"

    # Determine color
    if [[ ! $git_status =~ "working tree clean" ]]; then
        git_color="red"
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        git_color="yellow"
    fi

    echo " %F{240}git[%f$git_root:%F{$git_color}$git_branch%f%F{240}]%f"
}

function shell_level() {
    if [[ -z $SHLVL || $SHLVL < 2 ]]; then
        return
    fi

    echo ":$SHLVL"
}

setopt PROMPT_SUBST
RPROMPT=""
PROMPT="%(?.%F{green}✓.%F{red}[%?])%f %F{240}[$(hostname)$(shell_level)]%f %F{cyan}%~%f$(git_statusline)
λ "

