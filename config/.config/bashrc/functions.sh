#!/usr/bin/env bash

shopt -s extglob

extract() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case "$archive" in
      *.tar.bz2) tar xvjf "$archive" ;;
      *.tar.gz) tar xvzf "$archive" ;;
      *.bz2) bunzip2 "$archive" ;;
      *.rar) rar x "$archive" ;;
      *.gz) gunzip "$archive" ;;
      *.tar) tar xvf "$archive" ;;
      *.tbz2) tar xvjf "$archive" ;;
      *.tgz) tar xvzf "$archive" ;;
      *.zip) unzip "$archive" ;;
      *.Z) uncompress "$archive" ;;
      *.7z) 7z x "$archive" ;;
      *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

if [[ $- == *i* ]] && shopt -q extglob && type complete &>/dev/null; then
  complete -f -X '!*.@(tar|gz|bz2|zip|rar|7z|tar.gz|tar.bz2|tbz2|tgz)' extract
fi

countfiles() {
  for t in files links directories; do
    local type_flag="${t:0:1}"
    count=$(find . -type "$type_flag" 2>/dev/null | wc -l)
    echo "$count $t"
  done
}

ftext() {
  grep -iIHrn --color=always "$1" . | less -r
}

cpp() {
  set -e
  strace -q -ewrite cp -- "$1" "$2" 2>&1 | awk '
    {
      count += $NF
      if (count % 10 == 0) {
        percent = count / total_size * 100
        printf "%3d%% [", percent
        for (i = 0; i <= percent; i++) printf "="
        printf ">"
        for (i = percent; i < 100; i++) printf " "
        printf "]\\r"
      }
    }
    END { print "" }
  ' total_size="$(stat -c '%s' "$1")" count=0
}

cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

mkdirg() {
  mkdir -p "$1"
  cd "$1" || return
}

up() {
  local d=""
  for ((i = 1; i <= $1; i++)); do
    d="${d}/.."
  done
  d="${d#/}"
  [ -z "$d" ] && d=..
  cd "$d" || return
}

cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

pwdtail() {
  pwd | awk -F/ '{nlast = NF -1; print $nlast"/"$NF}'
}

distribution() {
  local dtype="unknown"
  if [ -r /etc/os-release ]; then
    source /etc/os-release
    case "$ID" in
    fedora | rhel | centos) dtype="redhat" ;;
    sles | opensuse*) dtype="suse" ;;
    ubuntu | debian) dtype="debian" ;;
    gentoo) dtype="gentoo" ;;
    arch | manjaro) dtype="arch" ;;
    slackware) dtype="slackware" ;;
    *)
      if [ -n "$ID_LIKE" ]; then
        case "$ID_LIKE" in
        *fedora* | *rhel* | *centos*) dtype="redhat" ;;
        *sles* | *opensuse*) dtype="suse" ;;
        *ubuntu* | *debian*) dtype="debian" ;;
        *gentoo*) dtype="gentoo" ;;
        *arch*) dtype="arch" ;;
        *slackware*) dtype="slackware" ;;
        esac
      fi
      ;;
    esac
  fi
  echo "$dtype"
}

ver() {
  local dtype
  dtype=$(distribution)
  case "$dtype" in
  redhat)
    if [ -s /etc/redhat-release ]; then
      cat /etc/redhat-release
    else
      cat /etc/issue
    fi
    uname -a
    ;;
  suse) cat /etc/SuSE-release ;;
  debian) lsb_release -a ;;
  gentoo) cat /etc/gentoo-release ;;
  arch) cat /etc/os-release ;;
  slackware) cat /etc/slackware-version ;;
  *) [ -s /etc/issue ] && cat /etc/issue || echo "Unknown distribution" ;;
  esac
}

gundo() {
  git reset --soft HEAD~1 && echo "Commit undone (soft)."
}

gcom() {
  if [ $# -eq 0 ]; then
    echo "Usage: gcom \"commit message\" or gcom file1 file2 ... \"msg\""
    return 1
  fi
  if [ $# -eq 1 ]; then
    git add . && git commit -m "$1"
  else
    local msg="${*: -1}"
    local files=("${@:1:$#-1}")
    git add "${files[@]}"
    git commit -m "$msg"
  fi
}

lazyg() {
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M')
  local messages=(
    "ugh, I'm probably just tweaking some annoying thing I missed before pushing the last time."
    "why is this always the last thing I see after pushing 😭"
    "tiny fix that shouldn't exist, but here we are."
    "did I push too early? yes. am I fixing it now? also yes."
    "fixing that one thing I swore was fine 10 minutes ago."
    "the commit of shame. [$timestamp]"
    "past me was too confident. again."
    "you didn't see this commit, okay?"
    "nothing to see here... just a tiny mistake with big dreams."
    "guess what? I forgot something. [$timestamp]"
  )

  local random_index=$((RANDOM % ${#messages[@]}))
  local random_msg="${messages[$random_index]} [$timestamp]"

  if [ $# -eq 0 ]; then
    git add .
    git commit -m "$random_msg"
  elif [ $# -eq 1 ]; then
    git add .
    git commit -m "$1"
  else
    local msg="${*: -1}"
    local files=("${@:1:$#-1}")
    git add "${files[@]}"
    git commit -m "$msg"
  fi

  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  git push -u origin "$current_branch"
}
