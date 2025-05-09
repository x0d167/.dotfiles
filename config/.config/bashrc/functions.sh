#!/usr/bin/env bash

shopt -s extglob

# ============================
# 🧰 Core File/Directory Helpers
# ============================

# 🔍 Enhanced file viewer: Use `bat` or `batcat` if available, otherwise fallback to regular `cat`.
cat() {
  if command -v batcat &>/dev/null; then
    batcat "$@"
  elif command -v bat &>/dev/null; then
    bat "$@"
  else
    command cat "$@"
  fi
}

# 📁 Smart cd: Changes directory and lists contents after entering.
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && zoxide add . && ls
  else
    builtin cd ~ && zoxide add . && ls
  fi
}

# 📁 Make dir and go: Creates directory and enters it.
mkdirg() {
  mkdir -p "$1"
  cd "$1" || return
}

# 📁 Move and go: Moves file and changes into target directory if it's a folder.
mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

# 📁 Copy and go: Copy a file and change into target directory if it's a folder.
cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

# 🛠️ Touch with mkdir: Like `touch`, but makes parent directories if needed.
touchy() {
  local target="$1"
  mkdir -p "$(dirname "$target")" && touch "$target"
}

# 📍 Short path: Prints last two directories of current path.
pwdtail() {
  pwd | awk -F/ '{nlast = NF -1; print $nlast"/"$NF}'
}

# ============================
# 📦 File Utilities
# ============================

# 📊 Count files: Counts number of files, links, and directories in current path.
countfiles() {
  for t in files links directories; do
    local type_flag="${t:0:1}"
    count=$(find . -type "$type_flag" 2>/dev/null | wc -l)
    echo "$count $t"
  done
}

# 📦 Copy with progress: Visual file copy with progress using `strace` and `awk`.
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
        printf "]\r"
      }
    }
    END { print "" }
  ' total_size="$(stat -c '%s' "$1")" count=0
}

# 📦 Extract archive: Extracts various archive formats with one command.
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

# ============================
# 🔎 Search / Navigation
# ============================

# 🔎 Find text: Case-insensitive recursive grep with pager.
ftext() {
  grep -iIHrn --color=always "$1" . | less -r
}

# ⬆️ Go up directories: Moves up N directory levels.
up() {
  local d=""
  for ((i = 1; i <= $1; i++)); do
    d="${d}/.."
  done
  d="${d#/}"
  [ -z "$d" ] && d=..
  cd "$d" || return
}

# 🔁 Wrap z() to auto-list after jumping
z() {
  if declare -f __zoxide_z &>/dev/null; then
    __zoxide_z "$@" && ls
  else
    echo "zoxide is not initialized. Did you source prompt.sh first?"
  fi
}

# ============================
# 🧠 System Info / OS
# ============================

# 💻 Detect distro: Detects and echoes the current Linux distribution type.
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

# 🔎 OS version: Prints version info of current Linux distribution.
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

# ============================
# 🧪 Git Shortcuts
# ============================

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

gundo() {
  git reset --soft HEAD~1 && echo "Commit undone (soft)."
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

# ============================
# 🛡️ Firewall / Network Zones
# ============================

_log_fw() {
  local log_dir="$HOME/.local/var/log/firewall"
  local log_file="$log_dir/zone-switch.log"

  mkdir -p "$log_dir"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$log_file"
}

fwstatus() {
  echo "🔥 Active Zones:"
  sudo firewall-cmd --get-active-zones
  echo
  echo "📋 Current Rules:"
  sudo firewall-cmd --list-all
}

pentestmode() {
  if [[ "$1" == "--dry-run" ]]; then
    echo "[DRY RUN] Would switch the following interfaces to 'pentest':"
    nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi" || $2=="ethernet" || $2=="tun" || $2=="vpn" {print " - " $1}'
    return
  fi

  _log_fw "Entering pentest mode..."
  for iface in $(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi" || $2=="ethernet" || $2=="tun" || $2=="vpn" {print $1}'); do
    _log_fw " → Assigning $iface to pentest zone"
    sudo firewall-cmd --zone=pentest --change-interface="$iface" --permanent
  done
  sudo firewall-cmd --reload
  fwstatus
  _log_fw "Pentest mode enabled."
}

normalmode() {
  if [[ "$1" == "--dry-run" ]]; then
    echo "[DRY RUN] Would switch the following interfaces to 'FedoraWorkstation':"
    nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi" || $2=="ethernet" || $2=="tun" || $2=="vpn" {print " - " $1}'
    return
  fi

  _log_fw "Reverting to FedoraWorkstation zone..."
  for iface in $(nmcli -t -f DEVICE,TYPE device status | awk -F: '$2=="wifi" || $2=="ethernet" || $2=="tun" || $2=="vpn" {print $1}'); do
    _log_fw " → Assigning $iface to FedoraWorkstation zone"
    sudo firewall-cmd --zone=FedoraWorkstation --change-interface="$iface" --permanent
  done
  sudo firewall-cmd --reload
  fwstatus
  _log_fw "Normal mode restored."
}

# ============================
# 📚 Index / Docs
# ============================

index() {
  local search="${1,,}"
  local lines=(
    "cat      - 🔍 Enhanced file viewer: Use bat/batcat if available."
    "cd       - 📁 Smart cd: Changes dir and lists contents."
    "countfiles - 📊 Count files: Show number of files, links, and dirs."
    "cpp      - 📦 Copy with progress: Shows progress bar via strace."
    "cpg      - 📁 Copy and go: Copy and enter the destination dir."
    "distribution - 💻 Detect distro: Guess your Linux flavor."
    "extract  - 📦 Extract archive: One-liner archive extractor."
    "ftext    - 🔎 Find text: Grep recursively with color."
    "fwstatus - 🔥 Show current firewalld active zones and rules."
    "gcom     - 🔧 Git commit helper: Commit with or without message."
    "gundo    - ↩️ Undo last Git commit: Soft reset."
    "lazyg    - 😅 Lazy Git commit: Commit with a snarky message."
    "mkdirg   - 📁 Make dir and go: mkdir + cd."
    "mvg      - 📁 Move and go: mv + cd if dir."
    "normalmode  - 🧱 Revert interfaces to 'FedoraWorkstation' zone (default security posture)."
    "pentestmode - 🛡️ Switch all interfaces to 'pentest' zone (all ports open)."
    "pwdtail  - 📍 Short path: Show last two segments of pwd."
    "touchy   - 🛠️ Touch with mkdir: Create file, ensure parent dir."
    "z        - 🚀 zoxide jump: Jump to frequent dirs and auto-ls after."
    "up       - ⬆️ Go up directories: Go up N levels."
    "ver      - 🔎 OS version: Show Linux distro version info."
  )

  echo -e "\n📚 Custom Function Index"
  echo "────────────────────────────"
  for line in "${lines[@]}"; do
    if [[ -z "$search" || "${line,,}" == *"$search"* ]]; then
      echo "$line"
    fi
  done
  echo
}

aliasindex() {
  local search="${1,,}"
  echo -e "\n📘 Alias Index"
  echo "────────────────────────────"
  alias | while read -r line; do
    if [[ -z "$search" || "${line,,}" == *"$search"* ]]; then
      echo "$line"
    fi
  done
  echo
}
