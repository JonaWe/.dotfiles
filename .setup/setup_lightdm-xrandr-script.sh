sudo sed -i '/display-setup-script/c\display-setup-script=xrandr --output DVI-D-0 --mode 1920x1080 --pos 3640x180 --rotate normal --rate 144 --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate left --output DP-0 --primary --mode 2560x1440 --pos 1080x0 --rotate normal --rate 144 --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off' /etc/lightdm/lightdm.conf