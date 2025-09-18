cat > /tmp/install_masterobot_clean.sh <<'SH'
#!/bin/bash
set -e

# Scarica e lancia lo script originale masterobot
wget -O /tmp/install_masterobot.sh https://pastebin.com/raw/sYefTG5A
sed -i 's/\r$//' /tmp/install_masterobot.sh
/bin/bash /tmp/install_masterobot.sh

# Abilita servizi utente
sudo loginctl enable-linger pi
systemctl --user daemon-reload
systemctl --user enable masterobot
systemctl --user start masterobot

# Abilita bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Abilita pipewire
systemctl --user enable --now pipewire wireplumber pipewire-pulse

# Messaggio finale
echo "----------------------------------------------------"
echo " Installazione completata!"
echo " Ora esegui manualmente:"
echo "   sudo raspi-config"
echo " Vai su 'System Options' e abilita il login automatico."
echo " Poi riavvia con: sudo reboot"
echo "----------------------------------------------------"
SH

chmod +x /tmp/install_masterobot_clean.sh
bash /tmp/install_masterobot_clean.sh
