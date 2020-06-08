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
cmd=$(eval tmux-print "'$@'")

# Get pane information
# TODO: Get scroll position
read -r pane_id pane_height mode scroll_pos <<<$(
	tmux display-message -p \
		'#{pane_id} #{pane_height} #{?pane_in_mode,1,0} #{scroll_position}'
)

# Create new window for scratchpad
scratch_name="[scratch-$pane_id]"
read -r scratch_window_id scratch_pane_id <<<$(
	eval tmux new-window -P -d -n "'$scratch_name'" \
		-F '"#{window_id} #{pane_id}"' \
		"'$cmd'"
)

# Close tmux pane on exit
tmux set-option -t "$scratch_pane_id" remain-on-exit on
tmux set-hook -t "$scratch_pane_id" pane-died \
	"swap-pane -s $pane_id -t $scratch_pane_id ; kill-pane -t $scratch_pane_id"

# Swap in new pane
tmux swap-pane -s $pane_id -t $scratch_pane_id

