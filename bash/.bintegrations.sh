#\\\\\\\\\#
#\\\FZF\\\#
#\\\\\\\\\#
export FZF_DEFAULT_COMMAND='find . -type d \( -name .venv -o -name __pycache__ -o -name .git \) -prune -o -type f -print'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash && eval "$(fzf --bash)"

#\\\ALIASES\\\#
alias drm='docker rm $(docker ps --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias drmi='docker rmi $(docker images --format "{{.ID}} {{.Repository}} {{.Tag}} {{.CreatedSince}}" | fzf --reverse | awk '"'"'{print $1}'"'"')'
alias ds='docker stop $(docker ps -a --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias dsrmi='c=$ds; [ -n "$c" ] && docker stop "$c" && sleep 3 && docker rm "$c"; i=$(docker images | fzf --reverse | awk '"'"'{print $1}'"'"'); [ -n "$i" ] && docker rmi "$i"'
#alias dsci='c=$(docker ps | fzf --reverse; [ -n "$c" ]) && docker stop "$c" && docker rm "$c"; i=$(docker images | fzf --reverse); [ -n "$i" ] && docker rmi $"i"'
alias fz="fzf --reverse --preview 'less {}'"
alias k8dp='microk8s kubectl describe pod $(microk8s kubectl get pods -A | fzf --reverse | awk  '"'"'{print $2}'"'"')'
#-------------#

#\\\FUNCTIONS\\\#
k8ex() {
  pod=$(microk8s kubectl get pods -A | fzf --reverse | awk '{print $2}')
  if [[ -n "$pod" ]]; then
    microk8s kubectl exec -it "$pod" -n "$1" -- bash
  else
    echo "exec command canceled"
  fi
}
#---------------#


#\\\\\\\\\\\\\\#
#\\\LESSPIPE\\\#
#\\\\\\\\\\\\\\#
command -v lesspipe &> /dev/null && eval "$(SHELL=/bin/sh lesspipe)"
#\\\\\\\\\\\\\\#


#\\\\\\\\\\\#
#\\\CONDA\\\#
#\\\\\\\\\\\#
# !! Contents within this block are managed by 'conda init' !!
condaa() {
  __conda_setup="$('/home/james/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/home/james/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/home/james/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/james/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}

alias condad='conda deactivate'
#-----------#


#\\\\\\\\\\\\\\\\\\\\\#
#\\\RANCHER\DESKTOP\\\#
#\\\\\\\\\\\\\\\\\\\\\#
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
[ -f "$HOME/.rd/bin" ] && [[ ":$PATH:" != *":$HOME/.rd/bin:"* ]] && export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)


#\\\\\\\\\\\\#
#\\\GOLANG\\\#
#\\\\\\\\\\\\#
[ -f $HOME/go/bin ] && [[ ":$PATH:" != *":$HOME/go/bin:"* ]] && export PATH="$HOME/go/bin:$PATH"


#\\\\\\\\\\\\\\#
#\\\HOMEBREW\\\#
#\\\\\\\\\\\\\\#
if command -v brew &>/dev/null; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
#--------------#
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
[ -f /home/linuxbrew/.linuxbrew/bin ] && [[ ":$PATH:" != *":/home/linuxbrew/.linuxbrew/bin:"* ]] && export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"


