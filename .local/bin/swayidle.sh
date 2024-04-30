#!/bin/bash

set -eufo pipefail

lock=/home/jona/.local/bin/swaylock.sh

exec swayidle -w \
     timeout 300 "$lock slow" \
     timeout 420 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
     before-sleep "$lock" \
     lock "$lock fast"
