#!/bin/bash
set -e

CONF="$HOME/.config/tmux/sessions"

expand_home() {
    echo "${1/\~/$HOME}"
}

selected="$1"
dest=$(awk '/^'"$selected"' /{print $3}' "$CONF")
dest=$(expand_home "$dest")

window_command() {
    echo "bash -c 'cd $path || echo && cd $dest || echo; $SHELL'"
}

window_file="$HOME/.config/tmux/session_windows/$selected"

if [ -f "$window_file" ]; then
    cat "$window_file" | while read line 
    do
        name=$(echo "$line" | awk '{print $1}')
        path=$(echo "$line" | awk '{print $2}')
        if [ "${path::1}" = "/" -o "${path::1}" = "~" ]; then
            path=$(expand_home "$path")
        else
            path="$dest/$path"
        fi

        if [ -z "$first" ]; then
            first=1
            tmux new-session -s "$selected" -n "$name" -c "$dest" -d \
                "$(window_command)"
        else
            tmux new-window -n "$name" -t "$selected" -d "$(window_command)"
        fi

    done
fi
if [ -z "$first" ]; then
    tmux new-session -s "$selected" -c "$dest" -d \
        "bash -c 'cd $dest || echo; $SHELL'"
fi
