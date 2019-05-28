
tmux-scratchpad
================================================================================

Description
--------------------------------------------------------------------------------
Quickly replaces the current pane with a scratchpad, where you can run commands or edit files. The original pane gets restored when finished.

[//]: # (TODO: Add gif.)


Installation
--------------------------------------------------------------------------------

### Via TPM (recommended)

``` tmux
set -g @plugin 'toddyamakawa/tmux-scratchpad'
```

[//]: # (TODO: Add mannual installation.)


Usage
--------------------------------------------------------------------------------

``` tmux
# Prompts user for command to run in scratchpad
# The default binding is prefix + C-s
set-option -g @scratch-command-key 'C-s'
```

Opening the `scratchpad command prompt` will look like this:

```
[scratchpad] Enter command:
```

When the command is finished, the original pane will be restored. `tmux` variables will be expanded. Here are some useful commands:
```
man tmux
git status #{pane_current_path} | less
```

It's also possible to bind useful commands:
```tmux
# Run git status with prefix + g
bind-key g run-shell -b "$HOME/.tmux/plugins/tmux-scratchpad/scripts/scratch_pane.bash 'git -C #{pane_current_path} status | less'"
```


About
--------------------------------------------------------------------------------

### Author
[toddyamakawa](https://github.com/toddyamakawa)

### License
[MIT](LICENSE.md)

