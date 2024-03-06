#!/bin/bash

set -eufo pipefail

lock=/home/jona/.local/bin/swaylock.sh

exec swayidle -w \
     timeout 180 "$lock slow" \
     timeout 300 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
     before-sleep "$lock" \
     lock "$lock fast"
