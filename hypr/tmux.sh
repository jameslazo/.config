#!/bin/bash
tmux attach -t $HOSTNAME &> /dev/null || tmux new -s $HOSTNAME "btop" \; new-window \; split-window -h \;

