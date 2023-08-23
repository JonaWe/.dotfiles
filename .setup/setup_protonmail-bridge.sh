echo "copying start scripts"
sudo cp ./scripts/start_protonmail-bridge.sh /usr/bin/start_protonmail-bridge.sh
sudo cp ./scripts/start_protonmail-bridge.service /etc/systemd/system/start_protonmail-bridge.service

echo "enabeling autostart for service"
sudo systemctl enable start_protonmail-bridge.service

echo "done"
