
# init.zsh

# Exit early if not interactive
[[ -o interactive ]] || return

# Run fastfetch if available in PATH
command -v fastfetch &>/dev/null && fastfetch

# Load completions and prompt handling
autoload -Uz compinit promptinit
compinit
promptinit
setopt prompt_subst

