#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 45 \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "$HOME/projects/spotify-polybar/target/release/spotify-polybar --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "$HOME/projects/spotify-polybar/target/release/spotify-polybar" &
#--match-command "`dirname $0`/get_spotify_status.sh --status" \ 
# --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

