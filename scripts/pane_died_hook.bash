#!/usr/bin/env bash

# Find original pane ID
scratch_pane_id="$(tmux display-message -p '#{pane_id}')"
original_pane_id="$(
	tmux list-windows -a -F '#{pane_id} #{window_name}' |
		awk "(\$2==\"[scratch-$scratch_pane_id]\") { print \$1; exit }"
)"

# If found, swap and kill
if [[ -n "$original_pane_id" ]]; then
	tmux swap-pane -s "$scratch_pane_id" -t "$original_pane_id"
	tmux kill-pane -t "$scratch_pane_id"
fi

