#!/usr/bin/env bash

# init.sh

# Exit early if not interactive
if [[ $- == *i* ]]; then
    export iatest=1
else
    export iatest=0
fi

# Run fastfetch if available
command -v fastfetch &>/dev/null && fastfetch

# Source system bash configs (optional)
[ -f /etc/bashrc ] && source /etc/bashrc

# Enable programmable completion (Bash only)
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
