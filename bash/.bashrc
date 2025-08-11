#\\\\\\EXEC-IT\\\\\\#
case $- in
    *i*) ;;
      *) return;;
esac
#-------------------#

#\\\\\\ENVVARS\\\\\\#
export CODE=$HOME/code
export CF=$HOME/.config
export CFB=$CF/bash
export EDITOR=/sbin/nvim
export FZF_ALT_C_OPTS=--walker-root=$HOME
export FZF_DEFAULT_OPTS_FILE=$CF/fzf/.fzfrc
export GTK_THEME=Adwaita-dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export GOPATH=$HOME/go
export GRIM_DEFAULT_DIR=$XDG_PICTURES_DIR/screenshots
export KUBE_EDITOR=/sbin/nvim
export KUBECONFIG=$HOME/.kube/kubeconfig
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export QT_STYLE_OVERRIDE=Adwaita-Dark
export SMB=/run/user/$UID/gvfs/smb-share:server=mojo.lan,share=glisamba
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
#export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=$HOME/.cache
export XDG_PICTURES_DIR=$HOME/Pictures
#------- IME -------#
GTK_IM_MODULE=wayland
QT_IM_MODULE=fcitx
QT_IM_MODULES="wayland;fcitx;ibus"
XMODIFIERS=@im=fcitx
#-------------------#

#\\\\\\OPTIONS\\\\\\#
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
#-------------------#

#\\\\\\ALIASES\\\\\\#
. $CFB/.balias.sh
#-------------------#

#\\\\\FUNCTIONS\\\\\#
. $CFB/.bfunctions.sh
#-------------------#

#\\\\\\HISTORY\\\\\\#
. $CFB/.bhistory.sh
#-------------------#

#\\\MISCELLANEOUS\\\#
. $CFB/.bmisc.sh
#-------------------#

#\\\\\\COLORS\\\\\\\#
. $CFB/.bcolors.sh
#. $CF/wal/theme
#-------------------#

#\\\\INTEGRATIONS\\\#
. $CFB/.bintegrations.sh
#-------------------#

#\\\\\\SECRETS\\\\\\#
. ~/secret/.config-secrets/.bsecrets
. ~/secret/.bashrc
#-------------------#

#\\\\\\\TEST\\\\\\\\#
. ~/secret/.test
#-------------------#
