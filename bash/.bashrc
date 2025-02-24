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
source $CFB/.balias.sh
#-------------------#

#\\\\\\HISTORY\\\\\\#
source $CFB/.bhistory.sh
#-------------------#

#\\\MISCELLANEOUS\\\#
source $CFB/.bmisc.sh
#-------------------#

#\\\\\\COLORS\\\\\\\#
source $CFB/.bcolors.sh
#-------------------#

#\\\INTEGRATIONS\\\#
source $CFB/.bintegrations.sh
#------------------#

