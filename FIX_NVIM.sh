#!/bin/bash

# Fix Neovim treesitter issues and reinstall plugins

clear

echo "═══════════════════════════════════════════════════════"
echo "    Neovim Plugin Reinstallation"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "This will:"
echo "  1. Clear Neovim plugin cache"
echo "  2. Reinstall all plugins fresh"
echo "  3. Install treesitter parsers"
echo ""
echo "Press Enter to continue..."
read

echo "Clearing Neovim cache..."
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
echo "✓ Cache cleared"
echo ""

echo "Opening Neovim to install plugins..."
echo "  - Plugins will auto-install"
echo "  - Wait for all installations to complete"
echo "  - Press 'q' to quit when done"
echo ""
echo "Opening Neovim in 3 seconds..."
sleep 3

# Open nvim with a simple file
nvim -c "echo 'Plugins installing... Wait for completion.'" /tmp/test.txt

echo ""
echo "═══════════════════════════════════════════════════════"
echo "✓ Neovim fixed!"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Test it:"
echo "  nvim ~/.zshrc"
echo ""
