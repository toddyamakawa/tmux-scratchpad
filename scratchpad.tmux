#!/usr/bin/env bash
declare -r CURRENT_DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
declare -r SCRIPTS_DIR="${CURRENT_DIR}/scripts"
source $SCRIPTS_DIR/helpers.sh

function main() {
	# Bind scratch_cmd.sh
	tmux bind-key $(tmux-get-option '@scratch-command-key' 'C-s') \
		run-shell -b ${SCRIPTS_DIR}/scratch_cmd.bash
	exit 0
}

main

