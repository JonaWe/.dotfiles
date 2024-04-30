#!/bin/bash

eww kill

MONITORS=$(swaymsg -t get_outputs | jq length)

for ((bar = 0; bar < MONITORS; bar++)); do
   eww open bar${bar}
   echo "Bar: bar${bar} launched"
done
