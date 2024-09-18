# My dotfiles

This directory contains the dotfiles for my system, organized with GNU Stow

## Requirements

Ensure you have the following installed on your system

### Git

```
sudo apt install stow
```

### Stow

```
sudo apt install stow 
```

## Installation

First, check out the dotfiles repo in you $HOME directory using git

```
$ git clone git@github.com/x0d12/.dotfiles.git
$ cd .dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

Here's a good simple video on the process for setting this all up: https://www.youtube.com/watch?v=y6XCebnB9gs
