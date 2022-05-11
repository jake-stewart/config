#!/bin/bash

# # DARK COLORS
# bright_bg="#303030"
# bright_fg="colour252"
# normal_bg="#191919"
# normal_fg="default"
# dimmed_fg="#404040"
# dimmed_bg="#191919"

# MEDIUM COLORS
bright_bg="#505050"
bright_fg="colour252"
normal_bg="#303030"
normal_fg="default"
dimmed_fg="#404040"
dimmed_bg="#303030"

# # LIGHT COLORS
# bright_bg="#c7c7c7"
# bright_fg="default"
# normal_bg="#dddddd"
# normal_fg="default"
# dimmed_fg="#aaaaaa"
# dimmed_bg="#dddddd"

invalid_bright_bg="colour174"
invalid_bright_fg="colour255"
invalid_normal_bg="colour95"
invalid_normal_fg="colour255"
invalid_dimmed_fg="colour138"
invalid_dimmed_bg="colour95"

zoomed_bright_bg="colour103"
zoomed_bright_fg="colour255"
zoomed_normal_bg="colour60"
zoomed_normal_fg="colour250"
zoomed_dimmed_bg="colour60"
zoomed_dimmed_fg="colour103"


bright_style="#{?#{window_zoomed_flag},#[fg=$zoomed_bright_fg#,bg=$zoomed_bright_bg],#{?#S,#[fg=$invalid_bright_fg#,bg=$invalid_bright_bg],#[fg=$bright_fg#,bg=$bright_bg]}}"
normal_style="#{?#{window_zoomed_flag},#[fg=$zoomed_normal_fg#,bg=$zoomed_normal_bg],#{?#S,#[fg=$invalid_normal_fg#,bg=$invalid_normal_bg],#[fg=$normal_fg#,bg=$normal_bg]}}"
dimmed_style="#{?#{window_zoomed_flag},#[fg=$zoomed_dimmed_fg#,bg=$zoomed_dimmed_bg],#{?#S,#[fg=$invalid_dimmed_fg#,bg=$invalid_dimmed_bg],#[fg=$dimmed_fg#,bg=$dimmed_bg]}}"

printf "#{?#{window_zoomed_flag},#[fill=$zoomed_normal_bg],#{?#S,#[fill=$invalid_normal_bg],#[fill=$normal_bg]}}"

# LEFT STATUS

windows=( $(tmux list-windows | awk -F ':' '{print $1}') )
active_window=( $(tmux list-windows | grep '(active)' | awk -F ':' '{print $1}') )

NONE=0
SELECTED=1
ACTIVE=2
INACTIVE=3
last_window=$NONE
idx=0

for ((i = 1; i < 10; i++)); do
    if [[ ${windows[$idx]} == $i ]]; then
        if [[ $i == $active_window ]]; then
            [ $last_window -ne $SELECTED ] \
                && printf "$bright_style" \
                && last_window=$SELECTED
        else
            [ $last_window -ne $ACTIVE ] \
                && printf "$normal_style" \
                && last_window=$ACTIVE
        fi
        ((idx++))
    else
        [ $last_window -ne $INACTIVE ] \
            && printf "$dimmed_style" \
            && last_window=$INACTIVE
    fi
    printf " $i "
done

# RIGHT STATUS
printf "#[align=right]"
printf "$bright_style #{pane_title} $normal_style $(date "+%H:%M %d-%b-%y") "
