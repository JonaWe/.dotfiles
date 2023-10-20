#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch all three bars
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
MONITOR=DP-4 polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
MONITOR=DP-6 polybar vertical 2>&1 | tee -a /tmp/polybar2.log & disown
#MONITOR=DVI-D-0 polybar second 2>&1 | tee -a /tmp/polybar3.log & disown

echo "Bars launched..."
