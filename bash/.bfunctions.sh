gp() {
  microk8s kubectl get pods -n $1
}
