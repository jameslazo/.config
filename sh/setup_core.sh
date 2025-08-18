#!/bin/bash
TMP_DIR=$(mktemp -d)
SRC_DIR=$HOME/.config
LOG_FILE=setup_core.log
DT_FORMAT='+%Y.%m.%d_%H:%M:%S'
set -euo pipefail
exec &>> $LOG_FILE

echo -e "-----$(date $DT_FORMAT)-----"

if [ ! -d $SRC_DIR ]; then
  echo "creating $SRC_DIR"
  mkdir -p $SRC_DIR
fi

PKG_MGR="$(which pacman) -Sy --needed --noconfirm" || "$(which apt) install -y" || "$(which dnf) install -y"

if [[ "$(whoami)" != "root" ]]; then
  $PKG_MGR="sudo $PKG_MGR"
fi

$PKG_MGR $(cat <<EOF
cronie
fzf
git
man-pages
tmux
tree
vim
wget
EOF
)
#ansible
#docker
#docker-compose
#jenkins
#k9s
#net-tools
#python
#terraform

tar -czf $HOME/.config.tar.gz $HOME

git clone https://github.com/jameslazo/.config $TMP_DIR

mv $TMP_DIR/{bash/.bashrc,fzf,sh,tmux,vim} $HOME/.config

echo "don't forget to source .bashrc"

echo -e "script completed at $(date $DT_FORMAT)"
