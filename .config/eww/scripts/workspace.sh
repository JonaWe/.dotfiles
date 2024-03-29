#!/bin/bash

on_changed() {
    swaymsg -t get_workspaces -r | jq -c
}

listen() {
    while true; do
        while read -r line; do
            on_changed
        done < <(swaymsg -t subscribe '["workspace"]')
    done
}

on_changed
listen
