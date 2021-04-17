#!/bin/bash
set -euo pipefail

# Basic script for setting up a tmux session for a C++ project that's built with Bazel.
# - creates a new session with windows / panes
# - names the session
# - sets up the session such that you can easily build e.g. upon changed files

path=$1
[[ $# -gt 1 ]] && sname=$2 || sname=$(basename $1)

# session and main window
tmux new-session -d -s "$sname" -c "$path" -n dev

# additional window
tmux splitw -c "$path" -t "$sname:0.0" "pwd; $SHELL"

# build window
tmux splitw -c "$path" -t "$sname:0.1" "pwd; $SHELL"
# send the command afterwards so we can still ctrl+c and don't run the build by default
tmux send-keys -t "$sname:0.2" 'find . -name "*.*pp" -o -name BUILD -o -name WORKSPACE | entr bazel test //...'

# set the layout
tmux select-layout -t "${sname}:0" main-horizontal


