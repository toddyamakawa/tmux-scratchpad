#!/usr/bin/env bash

# ==============================================================================
# FUNCTIONS
# ==============================================================================
function tmux-print() {
	eval tmux display-message -p '"$@"'
}


# TODO: Scroll position
read -r pane_id pane_height mode scroll_pos <<<$(
	tmux display-message -p \
		'#{pane_id} #{pane_height} #{?pane_in_mode,1,0} #{scroll_position}'
)


tmux set-option -g remain-on-exit on

cmd="$@"

# Create new window for scratchpad
scratch_name="[scratch-$pane_id]"
read -r scratch_window_id scratch_pane_id <<<$(
	eval tmux new-window -P -F '"#{window_id} #{pane_id}"' -d -n "'$scratch_name'" \
		$cmd
)

# Ensure window gets killed on exit
function at_exit() {
	local RETVAL=$?
	tmux swap-pane -s $pane_id -t $scratch_pane_id
	tmux kill-pane -t $scratch_pane_id
}
trap at_exit EXIT


tmux swap-pane -s $pane_id -t $scratch_pane_id

scratch_pane_status=alive
while [[ $scratch_pane_status == 'alive' ]]; do
	sleep 0.5
	scratch_pane_status=$(tmux display-message -p -t $scratch_pane_id '#{?pane_dead,dead,alive}')
done

