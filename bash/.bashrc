#!/usr/bin/env bash

# ➡️  This file is managed. Don’t edit directly.

# Modular Bash config loader
for part in init.sh exports.sh aliases.sh functions.sh prompt.sh; do
  [ -f "$HOME/.config/bashrc/$part" ] && source "$HOME/.config/bashrc/$part"
done
