gp() {
  microk8s kubectl get pods -n $1
}

ta() {
  tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME
}

upk9s() {
  wget https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && rm k9s_linux_amd64.deb
}

upfzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/.fzf && cp -r /tmp/.fzf ~ && ~/.fzf/install
}
