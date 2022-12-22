#!/bin/bash

CONF="$HOME/.config/jfind/sessions.json"

expand_home() {
    expanded=$1
    expanded=${expanded/\~/$HOME}
    expanded=${expanded/\$HOME/$HOME}
    echo "$expanded"
}

create_session() {
    dest=$(jq -r '."'"$selected"'".path' $CONF)
    dest=$(expand_home "$dest")
    tmux new-session -s "$selected" -c "$dest" -d "bash -c 'cd $dest; $SHELL'"

    for line in $(jq '."'"$selected"'".windows | keys[]' $CONF 2>/dev/null); do
        name=$(echo "$line" | sed -E 's/^"|"$//g')
        path=$(jq '."'"$selected"'".windows."'"$name"'"' $CONF)
        path=$(expand_home "$path")

        tmux new-window \
            -n "$name" \
            -t "$selected" \
            -d \
            "bash -c 'cd $path; $SHELL'"
    done
}

session_exists() {
    tmux list-sessions -F "#S" | grep "^$selected$" &>/dev/null
}

selected=$(~/.config/jfind/jfind-session.sh)
[ -z "$selected" ] && exit;

color=$(jq -r '."'"$selected"'".color' $CONF)

session_exists || create_session "$selected" "$dest"
tmux switch-client -t "$selected"
tmux set-environment session_color "$color"
