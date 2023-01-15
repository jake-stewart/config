#!/bin/bash
set -e

read_sessions() {
    awk '{print $1; $1 = ""; $2 = ""; print $3}' \
        ~/.config/tmux/sessions
}

jfind_command() {
    ~/.bin/jfind \
        --hints \
        --history="~/.cache/jfind-history/sessions"
}

read_sessions | jfind_command
