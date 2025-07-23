#\\\\\\\\\\\\\\\\\\\#
#\\\\\\HISTORY\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=200000000
HISTFILESIZE=200000000
HISTTIMEFORMAT="%F %T "
HISTFILE=$HOME/.bash_history
HISTIGNORE='?:??:l? *:pwd:exit:clear:cd ~*:history:git*:tmux:nano .git*:passwd *'
PROMPT_COMMAND='history -a; history -n'
#-------------------#
