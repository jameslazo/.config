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
export GOPATH=$HOME/go
export KUBE_EDITOR=/usr/bin/nano
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export FZF_ALT_C_OPTS=--walker-root=$HOME
export FZF_DEFAULT_OPTS_FILE=$CF/fzf/.fzfrc
export SMB=/run/user/$UID/gvfs/smb-share:server=mojo.lan,share=glisamba
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
#export XDG_DATA_DIRS=/usr/local/share/:/usr/share/
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=$HOME/.cache
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
#-------------------#

#\\\\INTEGRATIONS\\\#
. $CFB/.bintegrations.sh
#-------------------#

