#!/bin/bash
set -e

disable_cursor='echo "\x1b[?25l"'
"$HOME/.config/tmux/popup.sh" "$disable_cursor; $HOME/.config/jfind/jfind-project.sh; $disable_cursor"
# "$HOME/.config/tmux/popup.sh" "$disable_cursor; $HOME/fzf_test.sh; $disable_cursor"
