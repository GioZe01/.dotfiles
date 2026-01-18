#!/bin/bash

# Final installation steps that require sudo or user interaction
# Run this with: bash FINISH_INSTALL.sh

cd ~/.dotfiles

echo "========================================="
echo "Finishing Installation"
echo "========================================="
echo ""

# 1. Configure Italian keyboard
echo "1. Configuring Italian keyboard layout..."
bash scripts/set-italian-keyboard.sh

# 2. Set i3 as default desktop
echo ""
echo "2. Setting i3 as default desktop..."
bash scripts/set-i3-default.sh

# 3. Change default shell to zsh
echo ""
echo "3. Changing default shell to zsh..."
chsh -s $(which zsh)

echo ""
echo "========================================="
echo "✓ INSTALLATION COMPLETE!"
echo "========================================="
echo ""
echo "What was installed:"
echo "  ✓ All packages (zsh, tmux, neovim, i3, alacritty, etc.)"
echo "  ✓ Configuration symlinks created"
echo "  ✓ Oh My Zsh with plugins"
echo "  ✓ Tmux Plugin Manager"
echo "  ✓ Python venv for hyperdnabert"
echo "  ✓ Italian keyboard layout"
echo "  ✓ i3 as default desktop"
echo "  ✓ Zsh as default shell"
echo ""
echo "NEXT STEP: Log out and log back in"
echo ""
echo "You'll automatically boot into i3 window manager with:"
echo "  • Italian keyboard layout"
echo "  • Zsh shell"
echo "  • Multi-monitor support"
echo "  • Alacritty terminal (Ctrl+C/V works!)"
echo ""
echo "i3 Quick Reference:"
echo "  Mod+Return     = Open terminal (Alacritty)"
echo "  Mod+d          = Application launcher (rofi)"
echo "  Mod+Shift+q    = Close window"
echo "  Mod+h/j/k/l    = Navigate windows (vim-style)"
echo "  Mod+1-9        = Switch workspace"
echo "  Mod+Ctrl+h/j/k/l = Move workspace to different monitor"
echo "  Mod+p          = Monitor configuration (arandr)"
echo "  Mod is the Windows/Super key"
echo ""
echo "To switch back to GNOME:"
echo "  At login screen, click the gear icon and select 'GNOME'"
echo ""
