#!/bin/bash
set -e

echo ">>> Fix pacchetti bloccati (dpkg / apt)..."
sudo dpkg --configure -a || true
sudo apt-get install -f -y || true
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean

echo ">>> Scarico e avvio script masterobot..."
wget -O /tmp/install_masterobot.sh https://pastebin.com/raw/sYefTG5A
sed -i 's/\r$//' /tmp/install_masterobot.sh
/bin/bash /tmp/install_masterobot.sh

echo ">>> Abilito servizi utente..."
sudo loginctl enable-linger pi
systemctl --user daemon-reload
systemctl --user enable masterobot
systemctl --user start masterobot

echo ">>> Abilito bluetooth..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

echo ">>> Abilito pipewire..."
systemctl --user enable --now pipewire wireplumber pipewire-pulse

echo "----------------------------------------------------"
echo " Installazione completata!"
echo " Esegui ora:"
echo "   sudo raspi-config"
echo " Vai su 'System Options' e attiva il login automatico."
echo " Poi riavvia con: sudo reboot"
echo "----------------------------------------------------"