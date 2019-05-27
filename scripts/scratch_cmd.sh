#!/usr/bin/env bash
declare -r CURRENT_DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

tmux command-prompt -p "Enter command:" \
	"run-shell -b '${CURRENT_DIR}/scratch_pane.bash %%'"

