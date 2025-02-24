#\\\\\\\\\\\\\\\\\\\#
#\\\\\\HISTORY\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=20000
HISTFILESIZE=200000
HISTFILE=$HOME/.bash_history
HISTIGNORE='?:??:l? *:pwd:exit:clear:cd ~*:history:git*:tmux:nano .git*:passwd *'
PROMPT_COMMAND='history -a; history -n; history -r'
#-------------------#
