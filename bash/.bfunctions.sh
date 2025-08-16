#\\\\\\\\\\\\\\\#
#\\\FUNCTIONS\\\#
#\\\\\\\\\\\\\\\#
sb() {
  . $CFB/.bashrc
  pgrep tmux &>/dev/null && tmux source-file $CF/tmux/tmux.conf
  clear
}

mkcd() {
  if [ -z "$1" ]; then 
    echo "usage: mkcd PATH"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

mvsubd() {
  if [ -z "$1" ]; then 
    echo "usage: mvsubd SUBDIR"
    return 1
  fi
  for file in $(ls -A | grep -v "$1"); do
    mv $file "$1"
  done
}

nlog() {
  local log=$CODE/sandbox/log.md
  local today="# $(date '+%Y-%m-%d')"
  local entry=$(head -n 1 $log)
  [ "$today" != "$entry" ] && echo -e "$today\n## Projects\n- \n\n## Resources\n- []()\n\n" | cat - $log > $log && $EDITOR $log || $EDITOR $log
}

newsh() {
  local script_tmpl=$CFB/tmpl.sh
  if [ -n "$1" ]; then
    cp $script_tmpl "$1"
    $EDITOR "$1"
  else
    cp $script_tmpl .
    $EDITOR tmpl.sh
  fi
}

cbsub() {
  if [ $XDG_SESSION_TYPE != "wayland" ]; then
    echo "cbsub is for wayland sessions only"
    return 1
  elif [ $XDG_SESSION_TYPE == "wayland" ] && [ ! $(which wl-paste) ]; then
    sudo $PKG_MGR wl-clipboard
  fi
  if [ -z "$1" ]; then
    echo "usage: cbsub PATTERN1 PATTERN2 (omit PATTERN2 to delete PATTERN1)"
    return 1
  fi
  wl-paste -n | sed "s|$1|$2|g" | wl-copy -n
}

extract() {
  if [ ! -f "$1" ]; then
    echo "'$1' does not exist."
    return 1
  fi

  case "$1" in
    *.tar)                    tar xvf "$1"    ;;
    *.tar.gz | *.tgz)         tar xvzf "$1"   ;;
    *.gz)                     gunzip "$1"     ;;
    *.tar.bz2 | *.tbz2)       tar xvjf "$1"   ;;
    *.bz2)                    bunzip2 "$1"    ;;
    *.tar.xz)                 tar xvJf "$1"   ;;
    *.xz)                     xz -d "$1"      ;;
    *.7z)                     7z x "$1"       ;;
    *.rar)                    rar x "$1"      ;;
    *.zip)                    unzip "$1"      ;;
    *.Z)                      uncompress "$1" ;;
    *.a)                      ar x "$1"       ;;
    *.lzh | *.lzs | *.pma)    lha -x "$1"     ;;
    *)          echo "Unable to extract '$1'" ;;
  esac
}

gp() {
  microk8s kubectl get pods -n $1
}

upk9s() {
  if [[ $(echo "$PKG_MGR") == *"pacman"* ]]; then
    sudo $PKG_MGR k9s
  else
    echo "Installing from git repo..."
    cd $(mktemp -d) && wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb
  fi
}

upfzf() {
  if [[ $(echo "$PKG_MGR") == *"pacman"* ]]; then
    sudo $PKG_MGR fzf
  else
    echo "Installing from git repo..."
    tmpdir=$(mktemp -d)
    git clone --depth 1 https://github.com/junegunn/fzf.git ${tmpdir}/.fzf && cp -r ${tmpdir}/.fzf ~ && ~/.fzf/install
  fi
}


