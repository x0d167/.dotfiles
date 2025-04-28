#!/usr/bin/env bash

# General aliases
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ebrc='nvim ~/.bashrc'
alias hlp='less ~/.bashrc_help'
alias da='date "+%Y-%m-%d %A %T %Z"'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias py='python3'

# Conditional rm alias
if command -v trash &>/dev/null; then
  alias rm='trash -v'
else
  alias rm='rm -i'
fi

# Directory navigation
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Listing and viewing
alias rmd='/bin/rm  --recursive --force --verbose '
alias la='ls -Alh'
alias ls='eza -F --color=always --icons=always'
alias ll='eza -al --icons=always'
alias lx='ls -lXBh'
alias lk='ls -lSrh'
alias lc='ls -ltcrh'
alias lu='ls -lturh'
alias lr='ls -lRh'
alias lm='ls -alh |more'
alias lw='ls -xAh'
alias lt='eza -a --tree --level=1 --icons=always'
alias labc='ls -lap'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias lla='ls -Al'
alias las='ls -A'
alias lls='ls -l'
alias et='eza -T'
alias yf='yazi'
alias rf='ranger'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gpom='git push origin main'
alias gfo='git fetch origin'
alias ghelp='git help'
alias gclone='git clone'
alias ginit='git init'
alias gdiff='git diff'
alias gcheckout='git checkout'
alias gfetch='git fetch'
alias gb='git branch'

# chmod shortcuts (commented for later removal)
alias mx='chmod a+x'
# alias 000='chmod -R 000'
# alias 644='chmod -R 644'
# alias 666='chmod -R 666'
# alias 755='chmod -R 755'
# alias 777='chmod -R 777'

# Search & info
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep "
alias checkcommand="type -t"
alias checkrc='shellcheck ~/.bashrc'
alias openports='netstat -nape --inet'

# Reboot / shutdown
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias reboot='systemctl reboot'
alias shutdown='systemctl poweroff'

# Misc
alias linutil="curl -fsSL https://christitus.com/linux | sh"
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"
alias sha1='openssl sha1'
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias kssh="kitty +kitten ssh"
alias docker-clean='docker container prune -f; docker image prune -f; docker network prune -f; docker volume prune -f'
