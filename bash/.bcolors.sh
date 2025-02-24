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

# Git context
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

# Colorized prompt w/Git context
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[38;5;214m\]\u@\h\[\033[38;5;214m\]:\[\033[38;5;202m\]\w\[\033[38;5;37m\]$(parse_git)\[\033[38;5;223m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git)\$ '
fi

# Colorize remaining terminal elements
export LS_COLORS="rs=38;5;223:di=01;38;5;202:ex=38;5;156:ln=38;5;68:*.bak=38;5;130:*~=38;5;130:*.conf=38;5;89:"

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
