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
#-------------------#

#\\\\\\OPTIONS\\\\\\#
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
#-------------------#

#\\\\\\ALIASES\\\\\\#
. $CFB/.balias.sh
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
#---_---------------#

