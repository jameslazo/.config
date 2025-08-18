#---ENV VARS---#
export CODE=$HOME/code
export CF=$HOME/.config
export CFB=$CF/bash
export GOPATH=$HOME/go
export GRIM_DEFAULT_DIR=$XDG_PICTURES_DIR/screenshots
#export LC_ALL=en_US.UTF-8
#export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
export XDG_PICTURES_DIR=$HOME/Pictures

#---IME---#
GTK_IM_MODULE=wayland
QT_IM_MODULE=fcitx
QT_IM_MODULES="wayland;fcitx;ibus"
XMODIFIERS=@im=fcitx

#---ALIASES---#
alias code='code --disable-telemetry'
alias dt='cd ~/.config'
alias ff='fastfetch -l ~/Pictures/img/T480/t480.png --logo-recache'
alias grurp='grim -g "$(slurp)"'
alias hex='hyprctl dispatch exit'
alias hre='hyprctl reload'
alias nb='$EDITOR $CFB/.bashrc'
alias nbf='$EDITOR $CFB/.bashfull.sh'
alias nh='$EDITOR $CF/hypr/hyprland.conf'
alias nn='$EDITOR $CF/nvim/init.lua'
alias ta='tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME'
alias ts='date "+%y%m%d_%H%M%S"'
alias vs='code tunnel --disable-telemetry'
alias wgd='wg-quick down wg1'
alias wgu='wg-quick up wg1'

#---FUNCTIONS---#
nlog() {
  local log=$CODE/sandbox/log.md
  local today="# $(date '+%Y-%m-%d')"
  local entry=$(head -n 1 $log)
  [ "$today" != "$entry" ] && echo -e "$today\n## Projects\n- \n\n## Resources\n- []()\n\n" | cat - $log > $log && $EDITOR $log || $EDITOR $log
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

#---INTEGRATIONS---#
# !! Contents within this block are managed by 'conda init' !!
condaa() {
  __conda_setup=$("$HOME/miniconda3/bin/conda" 'shell.bash' 'hook' 2> /dev/null)
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
          . "$HOME/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="$HOME/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}

alias condad='conda deactivate'

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
[ -d $HOME/.rd/bin ] && [[ ":$PATH:" != *":$HOME/.rd/bin:"* ]] && export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

[ -d $HOME/go/bin ] && [[ ":$PATH:" != *":$HOME/go/bin:"* ]] && export PATH="$HOME/go/bin:$PATH"

if command -v brew &>/dev/null; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
[ -d /home/linuxbrew/.linuxbrew/bin ] && [[ ":$PATH:" != *":/home/linuxbrew/.linuxbrew/bin:"* ]] && export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

#---THEMES---#
. $CFB/.bthemes.sh
#. $CF/wal/theme

#---SECRETS---#
. $HOME/secret/.secret.sh

