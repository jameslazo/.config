#\\\\\\\\\\\\\\\#
#\\\FUNCTIONS\\\#
#\\\\\\\\\\\\\\\#
gp() {
  microk8s kubectl get pods -n $1
}

upk9s() {
  if [ -f "/usr/bin/apt" ]; then
    echo "Installing from git repo..."
    cd $(mktemp -d) && wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb
  elif [ -f "/usr/bin/pacman" ]; then
    echo "Installing via pacman..."
    sudo pacman -Sy k9s
  else
    echo "Neither apt nor pacman found. Skipping install."
  fi
}

upfzf() {
  if [ -f "/usr/bin/pacman" ]; then
    echo "Installing via pacman..."
    sudo pacman -Sy fzf
  else
    echo "Installing from git repo..."
    tmpdir=$(mktemp -d)
    git clone --depth 1 https://github.com/junegunn/fzf.git ${tmpdir}/.fzf && cp -r ${tmpdir}/.fzf ~ && ~/.fzf/install
  fi
}

sb() {
  . $CFB/.bashrc
  pgrep tmux &>/dev/null && tmux source-file $CF/tmux/tmux.conf
  clear
}

nlog() {
  log=$HOME/code/sandbox/log.md
  today="# $(date '+%Y-%m-%d')"
  entry=$(head -n 1 $log)
  [ "$today" != "$entry" ] && echo -e "$today\n## Projects\n- \n\n## Resources\n- []()\n\n$(cat $log)" > $log && nvim $log || nvim $log
}

extract() {
  if [ ! -f "$1" ] ; then
    echo "'$1' does not exist."
    return 1
  fi

  case "$1" in
    *.tar.bz2)                tar xvjf "$1"   ;;
    *.tar.xz)                 tar xvJf "$1"   ;;
    *.tar.gz)                 tar xvzf "$1"   ;;
    *.bz2)                    bunzip2 "$1"    ;;
    *.rar)                    rar x "$1"      ;;
    *.gz)                     gunzip "$1"     ;;
    *.tar)                    tar xvf "$1"    ;;
    *.tbz2)                   tar xvjf "$1"   ;;
    *.tgz)                    tar xvzf "$1"   ;;
    *.zip)                    unzip "$1"      ;;
    *.Z)                      uncompress "$1" ;;
    *.xz)                     xz -d "$1"      ;;
    *.7z)                     7z x "$1"       ;;
    *.a)                      ar x "$1"       ;;
    *.lzh | *.lzs | *.pma)    lha -x "$1"     ;;
    *)          echo "Unable to extract '$1'" ;;
  esac
}

mkcd() {
  mkdir -p $1
  cd $1
}

# WIP
#agenda() {
#  main=$HOME/code/meta/agenda.md
#  weekly=$HOME/code/meta/weekly.md
#  monthly=$HOME/code/meta/monthly.md
#  lt=$HOME/code/meta/longterm.md
#  mainlines=$(wc -l $main | awk '{print $1}')
#  weeklylines=$(wc -l $weekly | awk '{print $1}')
#  monthlylines=$(wc -l $monthly | awk '{print $1}')
#  ltlines=$(wc -l $lt | awk '{print $1}')
#  totallines=$((mainlines + weeklylines + monthlylines + ltlines))
#  today="# $(date '+%Y-%m-%d')"
#  entry=$(head -n $totallines $log)
#  [ "$today" != "$entry" ] && echo -e "$today\n## Projects\n- \n\n## Resources\n- []()\n\n$(cat $log)" > $log && nano $log || nano $log
#
#}
