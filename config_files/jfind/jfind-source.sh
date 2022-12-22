#!/bin/bash
set -e

[ -n "$1" ] && [ -f "$1" ] && rm "$1"

read_sources() {
    sed '/^$/d' ~/.config/jfind/sources
}

jfind_command() {
    ~/.bin/jfind \
        --hints \
        --select-hint \
        --history=~/.cache/jfind-history/sources
}

if [ -n "$1" ]; then
    read_sources | jfind_command > "$1"
else
    read_sources | jfind_command
fi
