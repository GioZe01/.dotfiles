#!/bin/bash

# Configure GNOME Terminal to use Ctrl+C and Ctrl+V for copy/paste

# Get default GNOME Terminal profile
PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

if [ -z "$PROFILE" ]; then
    echo "No default GNOME Terminal profile found"
    echo "Creating new profile..."
    # Create new profile if none exists
    dconf load /org/gnome/terminal/legacy/profiles:/ <<EOF
[:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
visible-name='Default'
EOF
    PROFILE="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
    gsettings set org.gnome.Terminal.ProfilesList default "$PROFILE"
fi

echo "Configuring GNOME Terminal profile: $PROFILE"

# Disable the menu accelerator key (so Ctrl+C/V can be used)
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false

# Set custom keybindings for copy/paste
# Note: GNOME Terminal doesn't natively support Ctrl+C/V, but we can use Ctrl+Shift+C/V
# For Ctrl+C/V to work, we need to use a different approach

cat << 'EOF'

GNOME Terminal Configuration Notes:
====================================

GNOME Terminal traditionally uses:
- Ctrl+Shift+C for copy
- Ctrl+Shift+V for paste

To enable Ctrl+C and Ctrl+V:

Option 1: Use when text is selected
GNOME Terminal can be configured to treat Ctrl+C as copy when text is selected.
This is done through the terminal preferences GUI:
  1. Open GNOME Terminal
  2. Edit -> Preferences -> Shortcuts
  3. Look for copy/paste shortcuts

Option 2: Install Alacritty (recommended)
Alacritty is a modern terminal with better keybinding support:
  sudo apt install alacritty

Then edit ~/.config/alacritty/alacritty.yml to add:
  key_bindings:
    - { key: C, mods: Control, action: Copy }
    - { key: V, mods: Control, action: Paste }

Option 3: Use tmux keybindings
Tmux already has copy/paste configured in ~/.tmux.conf
- Enter copy mode: Ctrl+a [
- Select text: v (vim-style)
- Copy: y (yanks to system clipboard)
- Paste: Ctrl+a ]

For now, GNOME Terminal will use Ctrl+Shift+C and Ctrl+Shift+V.

EOF
