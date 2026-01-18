#!/bin/bash

# Setup NordVPN permissions

echo "Setting up NordVPN permissions..."

# Create nordvpn group if it doesn't exist
if ! getent group nordvpn > /dev/null 2>&1; then
    sudo groupadd nordvpn
    echo "✓ Created nordvpn group"
fi

# Add current user to nordvpn group
sudo usermod -aG nordvpn $USER
echo "✓ Added $USER to nordvpn group"

echo ""
echo "NordVPN setup complete!"
echo ""
echo "IMPORTANT: You need to log out and log back in for group changes to take effect."
echo ""
echo "After logging back in, you can:"
echo "  - Login to NordVPN: nordvpn login"
echo "  - Connect: nordvpn connect"
echo "  - Disconnect: nordvpn disconnect"
echo ""
echo "i3 Keybindings:"
echo "  Mod+Shift+v    = Toggle VPN on/off"
echo "  Mod+Ctrl+v     = VPN menu (select country)"
echo ""
