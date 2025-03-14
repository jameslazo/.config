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

