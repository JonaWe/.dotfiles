sudo ln -s $HOME/.setup/keyboard-layout/gcj /usr/share/X11/xkb/symbols/gcj
setxkbmap -layout gcj

echo "copying start scripts"
sudo cp ./scripts/update_keyboard-layout /usr/bin/update_keyboard-layout
sudo cp ./scripts/start_keyboard-update.service /etc/systemd/system/start_keyboard-update.service

echo "enabeling autostart for service"
sudo systemctl enable start_keyboard-update.service

echo "done"
