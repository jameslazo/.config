#\\\\\\\\\\\\\\\\\\\#
#\\\\\\EXEC-IT\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
case $- in
    *i*) ;;
      *) return;;
esac
#-------------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\\\\ENVVARS\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
export CODE=$HOME/code
export CF=$HOME/.config
export FZF_DEFAULT_COMMAND='find . -type d \( -name .venv -o -name __pycache__ -o -name .git \) -prune -o -type f -print'
# export POSH_THEMES_PATH=$HOME/.cache/oh-my-posh/themes
#-------------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\\\\ALIASES\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
alias drm='docker rm $(docker ps --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias drmi='docker rmi $(docker images --format "{{.ID}} {{.Repository}} {{.Tag}} {{.CreatedSince}}" | fzf --reverse | awk '"'"'{print $1}'"'"')'
alias ds='docker stop $(docker ps -a --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias dsci='c=$docker ps | fzf --reverse; [ -n "$c" ] && docker stop "$c" && docker rm "$c"; i=$(docker images | fzf --reverse); [ -n "$i" ] && docker rmi $"i"'
alias dt='cd ~/.config'
alias fz="fzf --reverse --preview 'less {}'"
alias lS='ls -ShalF'
alias lx='ls -XhalFr'
alias lt='ls -thalF'
alias lr='ls -thalFr'
alias ll='ls -halF'
alias la='ls -Ah'
alias l='ls -CFh'
alias nb='nano $CF/bash/.bashrc'
alias nn='nano $CF/nano/nanorc'
alias sb='source ~/.config/bash/.bashrc && clear'
alias ta='tmux attach -t 1337'
alias vs='code tunnel --disable-telemetry'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
#-------------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\\\\HISTORY\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=20000
HISTFILESIZE=200000
HISTFILE=$HOME/.config/bash/.bash_history
HISTIGNORE='?:??:l? *:pwd:exit:clear:cd ~*:history:git*:tmux:nano .git*:passwd *'
PROMPT_COMMAND='history -a; history -n; history -r'
#-------------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\\\\OPTIONS\\\\\\#
#\\\\\\\\\\\\\\\\\\\#
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
#-------------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\MISCELLANEOUS\\\#
#\\\\\\\\\\\\\\\\\\\#
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#-------------------#


#\\\\\\\\\\\\#
#\\\COLORS\\\#
#\\\\\\\\\\\\#
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

LS_COLORS="rs=38;5;223:di=01;38;5;202:ex=38;5;156:ln=38;5;68:*.bak=38;5;130:*~=38;5;130:*.conf=38;5;89:"

function parse_git {
    local branch
    if branch=$(git symbolic-ref --short -q HEAD 2>/dev/null); then
        local status=""
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            status="*"  # Indicates uncommitted changes
        fi
        echo "::${branch}${status}"
    fi
}
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[oom\]:\[\033[01;34m\]\w\[\033[01;34m\]$(parse_git)\[\033[00m\]\$ '

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;214m\]\u@\h\[\033[38;5;214m\]:\[\033[38;5;202m\]\w\[\033[38;5;37m\]$(parse_git)\[\033[38;5;223m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git)\$ '
fi

#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#------------#


#\\\\\\\\\\\\\\\\\\\#
#\\\\INTEGRATIONS\\\#
#\\\\\\\\\\\\\\\\\\\#
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"
#eval "$(oh-my-posh init bash --config $POSH_THEMES_PATH/cobalt2.omp.json)"
#-------------------#

