#---EXEC IT---#
case $- in
    *i*) ;;
      *) return;;
esac

#---XDG---#
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=$HOME/.cache

#---CONFIG---#
if [[ ! -d $XDG_CONFIG_HOME ]]; then
  mkdir -p $XDG_CONFIG_HOME
fi

#---SOURCE---#
if [[ ! -f $HOME/.bashrc || ! $(grep ".bashrc" $HOME/.bashrc) ]]; then
  echo ". $(find $XDG_CONFIG_HOME $HOME -name .bashrc -print -quit)" >> $HOME/.bashrc
fi

#---PKG---#
export PKG_MGR=$(command -v pacman || command -v apt || command -v dnf)
export PKG_MGR_ALT=$(command -v yay || command -v yum || command -v snap || command -v brew)

base_pkg_chk() {
  # check for essential base packages 
  # package list
  local pkgs=(
    "nvim"
    "tree"
    "git"
    "tmux"
    "fzf"
    "zip"
    "unzip"
    "dig"
    "rsync"
    "curl"
    "bat"
  )

  # check for sudo requirement
  case $(whoami) in
    root|u0_*)
      local sutxt="" ;;
    *)
      local sutxt="sudo" ;;
  esac

  # set package install text
  if [[ $(echo "$PKG_MGR") == *"pacman"* ]]; then
    local install_cmd="$sutxt $PKG_MGR -S"
  else
    local install_cmd="$sutxt $PKG_MGR install"
  fi

  # define install conditions
  lets_install() {
    if ! $(command -v $1 &> /dev/null); then
      $install_cmd $1
    fi
  }

  # install package list as needed
  for i in ${pkgs[@]}; do
    lets_install $i
  done
}

base_pkg_chk

#---ENV VARS---#
export EDITOR=$(command -v nvim || command -v vim)
export FZF_ALT_C_OPTS="--walker-root=$HOME --walker-skip=.git --preview 'tree -C {}'"
export FZF_CTRL_R_OPTS="--no-preview"
export FZF_DEFAULT_OPTS_FILE=$XDG_CONFIG_HOME/fzf/.fzfrc
export KUBE_EDITOR=$EDITOR
export KUBECONFIG=$HOME/.kube/kubeconfig
export LANGUAGE=en_US.UTF-8

#---BASHRC FULL---#
if [[ -f $HOME/.config/bash/.bashfull.sh ]]; then
  . $HOME/.config/bash/.bashfull.sh
else
  echo "could not source full bash profile"
fi

#---INPUTRC---#
if [[ ! -f $HOME/.inputrc && -f $XDG_CONFIG_HOME/bash/.inputrc ]]; then
  ln -s $XDG_CONFIG_HOME/bash/.inputrc $HOME/.inputrc
fi

#---OPTIONS---#
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd

#---ALIASES---#
alias clear='TERMINFO=/usr/share/terminfo TERM=xterm /usr/bin/clear'
alias duh='du -h --max-depth=1'
alias dust='dust -r'
alias ls='ls -F --color=auto'
alias ld='ls -d */'
alias lsd='ls -d */**/'
alias lS='ls -ShAl'
alias lx='ls -XhAlr'
alias lr='ls -hAlR'
alias lt='ls -thAl'
alias ltr='ls -thAlr'
alias ll='ls -hAl'
alias la='ls -Ah'
alias l='ls -Ch'
alias ta='tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME "btop" \; new-window \; split-window -h \;'
alias td='tmux detach'
alias ts='date "+%y%m%d_%H%M%S"'

#---HISTORY---#
#HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s cdspell
shopt -s no_empty_cmd_completion
HISTSIZE=200000000
HISTFILESIZE=200000000
HISTFILE=$HOME/.bash_history
HISTIGNORE='?:??:pwd:exit:clear:cd ~*:history:git status:git add*:git commit*:tmux:nvim .git*:passwd *: *:wl-*:tldr *'
PROMPT_COMMAND='history -a'

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


#---FUNCTIONS---#
_dir_auto_complete() {
local cur="${COMP_WORDS[COMP_CWORD]}"
  # 1. Clear previous replies
  COMPREPLY=()

  # 2. Use readarray to handle spaces
  # -t removes trailing newlines
  # compgen -S "/" adds a trailing slash to directories
  readarray -t COMPREPLY < <(compgen -d -S "/" -- "$cur")

  # 3. Fix quoting: If the directory has a space, 
  # Bash needs to escape it (e.g., My\ Photos)
  if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
    # This part helps with auto-escaping when there's only one match
    printf -v COMPREPLY[0] '%q' "${COMPREPLY[0]}"
  fi
}

pd() {
  if [[ -z "$1" ]]; then
    local dirsp=$(dirs -p | tail -n +2 | fzf --height 10% --no-preview)
    [[ -n "$dirsp" ]] && cd "${dirsp/#\~/$HOME}"
  else
    if dirs -p | grep -qx "$1"; then
      cd "$1"
    else
      pushd "$1" > /dev/null
    fi
  fi
}

bm() {
  local symlink="${1:-$(pwd)}"
  local dirname="${2:-$(basename $symlink)}"
  if [[ ! -L ~/@/$dirname ]]; then
    ln -s $symlink ~/@/$dirname
  else
    echo "~/@/$dirname already exists"
  fi
}

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

complete -F _dir_auto_complete -o nospace mvsubd

newsh() {
  local sh_tmpl=$HOME/.config/sh/tmpl.sh
  local sh_name="${1:-tmpl.sh}"
  cp $sh_tmpl "$sh_name"
  $EDITOR "$sh_name"
}

extract() {
  if [[ ! -f "$1" ]]; then
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
  microk8s kubectl get pods -n "$1"
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
  . $HOME/.config/.bashrc
  pgrep tmux &>/dev/null && tmux source-file $HOME/.config/tmux/tmux.conf
}

