#\\\\\\\\\#
#\\\FZF\\\#
#\\\\\\\\\#
export FZF_DEFAULT_COMMAND='find . -type d \( -name .venv -o -name __pycache__ -o -name .git \) -prune -o -type f -print'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash && eval "$(fzf --bash)"

alias drm='docker rm $(docker ps --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias drmi='docker rmi $(docker images --format "{{.ID}} {{.Repository}} {{.Tag}} {{.CreatedSince}}" | fzf --reverse | awk '"'"'{print $1}'"'"')'
alias ds='docker stop $(docker ps -a --format "{{.ID}} {{.Image}} {{.Names}} {{.RunningFor}}" | fzf --reverse | awk  '"'"'{print $1}'"'"')'
alias dsci='c=$docker ps | fzf --reverse; [ -n "$c" ] && docker stop "$c" && docker rm "$c"; i=$(docker images | fzf --reverse); [ -n "$i" ] && docker rmi $"i"'
alias fz="fzf --reverse --preview 'less {}'"
alias k8dp='microk8s kubectl describe pod $(microk8s kubectl get pods -A | fzf --reverse | awk  '"'"'{print $2}'"'"')'
alias k8ex='microk8s kubectl exec -it $(microk8s kubectl get pods -A | fzf --reverse | awk  '"'"'{print $2}'"'"')' -- bash
#-----#


#\\\\\\\\\\\\\\#
#\\\LESSPIPE\\\#
#\\\\\\\\\\\\\\#
command -v lesspipe &> /dev/null && eval "$(SHELL=/bin/sh lesspipe)"
