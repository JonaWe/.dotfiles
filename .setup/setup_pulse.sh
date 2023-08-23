echo "installing pulse"
sudo pacman -Sy manjaro-pulse pavucontrol

echo "copying start scripts"
sudo cp ./scripts/start_pulse.sh /usr/bin/start_pulse.sh
sudo cp ./scripts/start_pulse.service /etc/systemd/system/start_pulse.service

echo "enabeling autostart for service"
sudo systemctl enable start_pulse.service

echo "done"
