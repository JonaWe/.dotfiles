#!/bin/bash

if [ -f /tmp/swayidle.pid ]; then
    kill $(cat /tmp/swayidle.pid)
    rm /tmp/swayidle.pid
fi

pkill -RTMIN+10 waybar
