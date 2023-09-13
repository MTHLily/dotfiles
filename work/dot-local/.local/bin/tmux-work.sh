#!/bin/bash

readarray -t WORKDIRS < ~/.config/tmux/vars/tmux-work-dirs

DIRS=()
for dir in "${WORKDIRS[@]}"; do
    DIRS+=("$(eval echo "$dir")")
done
fd --type directory --maxdepth 1 . "${DIRS[@]}"
choice=$(fd --type directory --maxdepth 1 . "${DIRS[@]}" \
    | awk 'match($0, /\/[A-z\-0-9\.]+\/$/){ 
        printf "%20s\t%s\n", substr($0, RSTART+1, RLENGTH-2), $1}
    ' \
        | fzf --preview "exa --icons \$(echo {} | awk '{print \$2}')" | awk '{print $2}')

tmux neww -c "$choice"
