#---EXEC IT---#
case $- in
    *i*) ;;
      *) return;;
esac

#---ENV VARS---#
export EDITOR="$(which vim)"
export FZF_ALT_C_OPTS=--walker-root=$HOME
export FZF_DEFAULT_COMMAND='find . -type d \( -name .venv -o -name __pycache__ -o -name .git \) -prune -o -type f -print'
export FZF_DEFAULT_OPTS_FILE=$HOME/.config/fzf/.fzfrc
export KUBE_EDITOR=$EDITOR
export KUBECONFIG=$HOME/.kube/kubeconfig
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PKG_MGR="$(find /usr/bin -name pacman -o -name apt -o -name dnf)"
export PKG_MGR_ALT="$(find /usr/bin -name yay -o -name yum -o -name snap -o -name brew)"
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=$HOME/.cache

#---BASHRC FULL---#
if [[ -f $HOME/.config/bash/.bashfull.sh ]]; then
  . $HOME/.config/bash/.bashfull.sh
else
  echo "could not source full bash profile"
fi

#---OPTIONS---#
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd

#---ALIASES---#
alias clear='TERMINFO=/usr/share/terminfo TERM=xterm /usr/bin/clear'
alias dush='sudo du -h --max-depth=1'
alias dust='dust -r'
alias ls='ls --color=auto'
alias lS='ls -ShAlF'
alias lx='ls -XhAlFr'
alias lr='ls -hAlFR'
alias lt='ls -thAlF'
alias ltr='ls -thAlFr'
alias ll='ls -hAlF'
alias la='ls -Ah'
alias l='ls -CFh'
alias ta='tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME'
alias ts='date "+%y%m%d_%H%M%S"'

#---HISTORY---#
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=200000000
HISTFILESIZE=200000000
HISTFILE=$HOME/.bash_history
HISTIGNORE='?:??:pwd:exit:clear:cd ~*:history:git status:git add*:git commit*:tmux:nvim .git*:passwd *:[ \t]*:wl-*:tldr *'
PROMPT_COMMAND='history -a; history -n'

#---MISCELLANEOUS---#
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#---CONFIG---#
if [[ ! -d $HOME/.config ]]; then
  mkdir -p $HOME/.config
fi

#---FUNCTIONS---#
mkcd() {
  if [[ -z $1 ]]; then
    echo "usage: mkcd PATH"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

cpsubd() {
  local subd="${1:-.bak}"
  if [[ $subd =~ ^-h$ ]]; then
    echo "usage: cpsubd SUB_DIR (optional: defaults to '.bak')"
    return
  fi
  mkdir -p "$subd"
  cp -r $(ls -A | grep -v "$subd") "$subd" || echo "empty directory"
}

mvsubd() {
  local subd="${1:-.bak}"
  if [[ $subd =~ ^-h$ ]]; then
    echo "usage: mvsubd SUB_DIR (optional: defaults to '.bak')"
    return
  fi
  mkdir -p "$subd"
  mv $(ls -A | grep -v "$subd") "$subd" || echo "empty directory"
}

newsh() {
  local sh_tmpl=$HOME/.config/sh/tmpl.sh
  local sh_name"${1:-tmpl.sh}"
  cp $sh_tmpl "$1"
  $EDITOR "$1"
}

extract() {
  if [[ ! -f $1 ]]; then
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

k8ex() {
  pod=$(microk8s kubectl get pods -A | fzf --reverse | awk '{print $2}')
  if [[ -n "$pod" ]]; then
    microk8s kubectl exec -it "$pod" -n "$1" -- bash
  else
    echo "exec command canceled"
  fi
}

command -v lesspipe &> /dev/null && eval "$(SHELL=/bin/sh lesspipe)"
command -v fzf &> /dev/null && eval "$(fzf --bash)"

upk9s() {
  if [[ $(echo "$PKG_MGR") == *"pacman"* ]]; then
    [ "$(whoami)" == "root" ] && $PKG_MGR k9s || sudo $PKG_MGR k9s
  else
    echo "Installing k9s from git repo..."
    cd $(mktemp -d) && wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb
  fi
}

upfzf() {
  if [[ $(echo "$PKG_MGR") == *"pacman"* ]]; then
    [ "$(whoami)" == "root" ] && $PKG_MGR fzf || sudo $PKG_MGR fzf
  else
    echo "Installing fzf from git repo..."
    local tmpdir=$(mktemp -d)
    git clone --depth 1 https://github.com/junegunn/fzf.git ${tmpdir}/.fzf && cp -r ${tmpdir}/.fzf ~ && ~/.fzf/install
  fi
}

sb() {
  if [[ ! -f $HOME/.config/.bashrc ]]; then
    ln -s $(find $HOME/.config $HOME -name .bashrc -print -quit) $HOME/.config/.bashrc
  fi
  . $HOME/.config/.bashrc
  pgrep tmux &>/dev/null && tmux source-file $HOME/.config/tmux/tmux.conf
}

