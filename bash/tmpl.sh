#!/bin/bash
TMP_DIR=$(mktemp -d)
SRC_DIR= #src_path
TGT_DIR= #tgt_path
LOG_FILE=script.log
DT_FORMAT='+%Y.%m.%d_%H:%M:%S'
set -euo pipefail
exec &>> $LOG_FILE

echo -e "-----$(date $DT_FORMAT)-----"

example1() {
  if [ ! -d $SRC_DIR ]; then
    echo "$SRC_DIR not found - exiting"
    return 1
  fi
}

example2() {
  if [ -d $TGT_DIR ]; then
    echo "$TGT_DIR found"
  fi
}

example1
example2

echo -e "script completed at $(date $DT_FORMAT)"
