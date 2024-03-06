#!/bin/bash

wallpaper_dir="/home/jona/Pictures/Wallpapers/selection/"
active="/home/jona/Pictures/Wallpapers/active.jpg"

random_wallpaper=$(find "$wallpaper_dir" -type f | shuf -n 1)

ln -sf "$random_wallpaper" "$active"

swww img  --resize crop --transition-type fade --transition-duration 0.25 ~/Pictures/Wallpapers/active.jpg
