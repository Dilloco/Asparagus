#!/bin/bash

echo "Updating package list..."
sudo apt update

echo "Installing Konqueror..."
sudo apt install -y konqueror

echo "Installing Openbox..."
sudo apt install -y openbox

echo "Installing gnome-terminal..."
sudo apt install -y gnome-terminal

echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y
sudo apt clean

echo "Configuring Konqueror to start in fullscreen..."
echo 'konqueror --fullscreen &' >> ~/.xinitrc
chmod +x ~/.xinitrc

echo "Configuring Openbox..."
mkdir -p ~/.config/openbox
cat > ~/.config/openbox/autostart <<EOF
openbox-session &

EOF

echo "Setting up Openbox keybindings for terminal..."
cat > ~/.config/openbox/rc.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<openbox_config>
  <keyboard>
    <keybind key="C-A T">
      <action name="Execute">
        <command>gnome-terminal</command>
      </action>
    </keybind>
  </keyboard>
</openbox_config>
EOF

echo "Creating ~/.xprofile..."
echo "exec openbox-session" > ~/.xprofile

echo "Enabling autologin..."
echo -e "[SeatDefaults]\nautologin-user=$(whoami)\nautologin-session=default" | sudo tee -a /etc/lightdm/lightdm.conf

echo "Final cleanup..."
sudo apt autoremove -y
sudo apt clean

echo "Asparagus minimal DE setup complete."
