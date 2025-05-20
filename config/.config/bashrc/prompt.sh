#!/usr/bin/env bash

# Ctrl+F inserts 'zi' in interactive shells
if [[ $- == *i* ]]; then
    bind '"\C-f":"zi\n"'
fi

# Prompt tool setup (Starship or Oh My Posh)
# eval "$(starship init bash)"
eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/EDM115-newline.omp.json)"

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# z is hard to type but c'est la vie
eval "$(zoxide init bash)"
eval "$(atuin init bash)"

export _ZO_DOCTOR=0
