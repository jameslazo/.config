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
export KUBE_EDITOR=/usr/bin/nano
export LANG=C
export SMB='/run/user/$UID/gvfs/smb-share:server=mojo.lan,share=glisamba'
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

