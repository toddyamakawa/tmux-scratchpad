#!/usr/bin/env bash

# ==============================================================================
# FUNCTIONS
# ==============================================================================
function tmux-print() {
	eval tmux display-message -p "'$@'"
}


# ==============================================================================
# MAIN
# ==============================================================================

# Parse args
cmd="$@"
if [[ -z $cmd ]]; then
	tmux display-message 'scratchpad: command missing'
	exit
fi
cmd=$(eval tmux-print "$@")

# Get pane information
# TODO: Get scroll position
read -r pane_id pane_height mode scroll_pos <<<$(
	tmux display-message -p \
		'#{pane_id} #{pane_height} #{?pane_in_mode,1,0} #{scroll_position}'
)

# TODO: Restore option after script is done
# TODO: Figure out a better way to do this
tmux set-option -g remain-on-exit on

# Create new window for scratchpad
scratch_name="[scratch-$pane_id]"
read -r scratch_window_id scratch_pane_id <<<$(
	eval tmux new-window -P -d -n "'$scratch_name'" \
		-F '"#{window_id} #{pane_id}"' \
		$cmd
)

# Ensure window gets killed on exit
function at_exit() {
	local RETVAL=$?
	tmux swap-pane -s $pane_id -t $scratch_pane_id
	tmux kill-pane -t $scratch_pane_id
}
trap at_exit EXIT

# Swap in new pane
tmux swap-pane -s $pane_id -t $scratch_pane_id

# Wait for pane to die
scratch_pane_status=alive
while [[ $scratch_pane_status == 'alive' ]]; do
	sleep 0.5
	scratch_pane_status=$(tmux display-message -p -t $scratch_pane_id '#{?pane_dead,dead,alive}')
done

