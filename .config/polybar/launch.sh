#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar
#
monitors=$(xrandr | grep " connected " | awk '{ print$1 }')

echo $monitors

for monitor in $monitors; do
    case $monitor in
        "eDP")
            MONITOR=$monitor polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
            ;;
        *)
            MONITOR=$monitor polybar second 2>&1 | tee -a /tmp/polybar1.log & disown
            ;;
    esac
done

# Launch all three bars
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
# MONITOR=eDP polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
#MONITOR=HDMI-0 polybar vertical 2>&1 | tee -a /tmp/polybar2.log & disown
#MONITOR=DP-3 polybar second 2>&1 | tee -a /tmp/polybar3.log & disown

echo "Bars launched..."
