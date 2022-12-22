#!/bin/bash
set -e

read_sessions() {
    jq -r 'keys[] as $k | "\($k)\n\(.[$k] | .path) "' ~/.config/jfind/sessions.json
}

join() {
    tr '\n' "$1" | sed 's/.$//'
}

remove_active_sessions() {
    sessions=$(tmux list-sessions -F '#S' | join '|')
    awk "/^($sessions)$/{d=2}{if(d){d-=1}else{print \$0}}"
}

inactive_sessions() {
    read_sessions | remove_active_sessions
}

active_sessions() {
    # tmux list-sessions -F $'#S\n#{session_path} [#{session_windows} windows]'
    tmux list-sessions -F $'#S\n#{session_path}*'
    # tmux list-sessions -F $'#S\n#{session_path} \x1b[0m*\x1b[90m'
}

jfind_command() {
    ~/.bin/jfind \
        --hints \
        --history="~/.cache/jfind-history/sessions"
}

{ inactive_sessions; active_sessions; } | jfind_command
