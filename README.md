# My dotfiles

This directory contains the dotfiles for my system, organized with GNU Stow

## Requirements

Ensure you have the following installed on your system

### Git

### Stow


## Installation
Don't forget to backup any relevant configs to refer back to before they're overwritten by this

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/x0d12/.dotfiles.git
$ cd .dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

