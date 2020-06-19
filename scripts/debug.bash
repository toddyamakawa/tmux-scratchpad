#!/usr/bin/env bash
# Run this scrip to print tmux settings
PAGER=cat
#PAGER='less -R'
{
	echo -e "\$TMUX_PANE='$TMUX_PANE'"
	echo -e "\n\e[40;1mHOOKS                                                                           \e[0m"
	tmux show-hooks -t "$TMUX_PANE"
	echo -e "\n\e[40;1mOPTIONS                                                                         \e[0m"
	tmux show-options -t "$TMUX_PANE"
	echo -e "\n\e[40;1mWINDOW-OPTIONS                                                                  \e[0m"
	tmux show-window-options -t "$TMUX_PANE"
	#echo -e "\n\e[40;1mGLOBAL-OPTIONS                                                                  \e[0m"
	#tmux show-options -g
	#echo -e "\n\e[40;1mGLOBAL-WINDOW-OPTIONS                                                                  \e[0m"
	#tmux show-window-options -g
} | $PAGER

