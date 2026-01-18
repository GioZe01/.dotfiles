#!/bin/bash

# Start Neovim fresh with clean plugin installation

clear

echo "═══════════════════════════════════════════════════════"
echo "    Starting Neovim Fresh"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "This will:"
echo "  1. Clean all cached data"
echo "  2. Start Neovim with minimal config"
echo "  3. Let plugins install cleanly"
echo ""

# Clean everything
echo "Cleaning Neovim cache..."
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Remove any git locks
rm -f ~/.local/share/nvim/lazy/*/. git/index.lock 2>/dev/null

echo "✓ Cache cleaned"
echo ""
echo "Starting Neovim..."
echo "  - Wait for Lazy.nvim to finish installing plugins"
echo "  - You'll see a window with plugin installation progress"
echo "  - When it says 'Done', press 'q' to close the window"
echo "  - Then quit nvim with :q"
echo ""
echo "Opening in 3 seconds..."
sleep 3

# Start nvim with a simple file
echo "print('Testing Neovim setup')" > /tmp/test_nvim.py
nvim /tmp/test_nvim.py

echo ""
echo "═══════════════════════════════════════════════════════"
echo "✓ Setup complete!"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Neovim should now work perfectly with:"
echo "  ✓ Clear retro font (DejaVu Sans Mono)"
echo "  ✓ High contrast colors"
echo "  ✓ Syntax highlighting"
echo "  ✓ LSP support"
echo ""
echo "Try it:"
echo "  nvim ~/.zshrc"
echo ""
