#!/bin/bash

color="#$1"

device="hidpp_battery_0"
device_path="/sys/class/power_supply/$device"

if [ ! -d "$device_path" ]; then
    # mouse is not connected
    echo "%{F$color}%{F-}"
    exit
fi

device_capacity_path="$device_path/capacity"
device_status_path="$device_path/status"

device_status=$(cat $device_status_path)
device_capacity=$(cat $device_capacity_path)

if [[ "$device_status" == "Discharging" ]]; then

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
    exit
fi

connected_devices="$(find /sys/class/power_supply/hidpp_battery_* -maxdepth 0 | wc -l)"

if [ "$connected_devices" -eq "1" ]; then
    echo "%{F$color}%{F-} $device_capacity%"
    exit
fi

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
