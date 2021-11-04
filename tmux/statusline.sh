#!/bin/bash


windows=( $(tmux list-windows | awk -F ':' '{print $1}') )
active_window=( $(tmux list-windows | grep '(active)' | awk -F ':' '{print $1}') )


SELECTED=0
ACTIVE=1
INACTIVE=2
last_window=-1
idx=0

for ((i = 1; i < 10; i++)); do
    if [[ ${windows[$idx]} == $i ]]; then
        if [[ $i == $active_window ]]; then
            [ $last_window -ne $SELECTED ] && printf '#[fg=default,bg=#505050]'
            $last_window=$SELECTED
        else
            [ $last_window -ne $ACTIVE ] && printf '#[fg=default,bg=#303030]'
            $last_window=$ACTIVE
        fi
        idx=$(( idx + 1 ));
    else
        [ $last_window -ne $INACTIVE ] && printf '#[fg=#505050,bg=default]'
        $last_window=$INACTIVE
    fi
    printf " $i "
done
