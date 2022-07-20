#!/bin/sh

color="#$1"

device="hidpp_battery_0"
device_path="/sys/class/power_supply/$device"

device_capacity_path="$device_path/capacity"
device_status_path="$device_path/status"

device_capacity=$(cat $device_capacity_path)
device_status=$(cat $device_status_path)

if [[ "$device_status" == "Unknown" ]]; then
    if [[ "$device_capacity" -lt "20" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "30" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "40" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "60" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "80" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "90" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    else
        echo "%{F$color}%{F-} $device_capacity%"
    fi
else
    if [[ "$device_capacity" -lt "5" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "10" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "20" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "30" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "40" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "50" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "60" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "70" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "80" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    elif [[ "$device_capacity" -lt "90" ]]; then
        echo "%{F$color}%{F-} $device_capacity%"
    else
        echo "%{F$color}%{F-} $device_capacity%"
    fi
fi
