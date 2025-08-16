#\\\\\\\\\\\\\\\\\\\#
#\\\\\\HISTORY\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=200000000
HISTFILESIZE=200000000
#HISTTIMEFORMAT="%F %T "
HISTFILE=$HOME/.bash_history
HISTIGNORE='?:??:pwd:exit:clear:cd ~*:history:git status:git add*:git commit*:tmux:nvim .git*:passwd *:[ \t]*:wl-*'
PROMPT_COMMAND='history -a; history -n'
#-------------------#:w

