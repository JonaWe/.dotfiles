#!/bin/bash

on_changed() {
    swaymsg -r -t get_tree | jq -r 'recurse(.nodes[]) | select(.focused == true and .type != "workspace") | .name' | cut -c1-40
}

listen() {
    while true; do
        while read -r line; do
            on_changed
        done < <(swaymsg -t subscribe '["window"]')
    done
}

on_changed
listen
