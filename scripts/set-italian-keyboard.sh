#!/bin/bash

# Configure Italian keyboard layout system-wide

set -e

echo "Configuring Italian keyboard layout..."

# Set keyboard layout for X11 (used by i3, GNOME on X11, etc.)
sudo tee /etc/default/keyboard > /dev/null << 'EOF'
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="it"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
EOF

# Set keyboard layout for current session
setxkbmap -layout it

# For GNOME/GDM
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'it')]" 2>/dev/null || true

# Update keyboard configuration
sudo dpkg-reconfigure -f noninteractive keyboard-configuration

echo "✓ Italian keyboard layout configured"
echo "  Layout: Italian (it)"
echo "  Applied to: X11, GNOME, i3"
