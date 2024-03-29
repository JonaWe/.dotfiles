#!/bin/bash

on_changed() {
    swaymsg -t get_binding_state -r | jq -r '.name'
}

listen() {
    while true; do
        while read -r line; do
            on_changed
        done < <(swaymsg -t subscribe '["mode"]')
    done
}

on_changed
listen
