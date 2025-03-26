gp() {
  microk8s kubectl get pods -n $1
}

ta() {
  tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME
}

upk9s() {
  stamp=$(date "+%y%m%d_%H%M%S")
  mkdir -p /tmp/k9s/${stamp} && cd /tmp/k9s/${stamp} && wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb
}

upfzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/.fzf && cp -r /tmp/.fzf ~ && ~/.fzf/install
}
