
# prompt.zsh

# Ctrl+F inserts 'zi' and presses enter
[[ -o interactive ]] && bindkey -s '^F' 'zi\n'

# Load your Oh My Posh prompt (or use Starship if you prefer)
# eval "$(starship init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/EDM115-newline.omp.json)"

# Completion init for tools
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval "$(zoxide init --cmd cd zsh)"
