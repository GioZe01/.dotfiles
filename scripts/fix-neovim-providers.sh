#!/bin/bash

# Fix Neovim providers and health check warnings

set -e

echo "========================================="
echo "Fixing Neovim Health Check Issues"
echo "========================================="
echo ""

# Fix 1: Install pynvim in current venv (if active)
if [ -n "$VIRTUAL_ENV" ]; then
    echo "✓ Virtual environment detected: $VIRTUAL_ENV"
    echo "Installing pynvim and jupytext in current venv..."
    pip install pynvim jupytext
    echo "✓ Python packages installed in venv"
else
    echo "⚠ No virtual environment active"
    echo "Python packages will be installed with --user flag"
    pip install --user pynvim jupytext
    echo "✓ Python packages installed globally"
fi

echo ""
echo "Fix 1/5: Python provider ✓"
echo ""

# Fix 2: Install Node.js and npm (for treesitter and markdown-preview)
echo "Fix 2/5: Installing Node.js and npm..."
if command -v node &> /dev/null; then
    echo "✓ Node.js already installed: $(node --version)"
else
    echo "Installing Node.js and npm..."
    sudo apt update
    sudo apt install -y nodejs npm
    echo "✓ Node.js and npm installed"
fi

echo ""
echo "Fix 3/5: Tmux focus-events configuration..."
TMUX_CONF="$HOME/.tmux.conf"

if grep -q "focus-events" "$TMUX_CONF" 2>/dev/null; then
    echo "✓ focus-events already configured in tmux"
else
    echo "Adding focus-events to ~/.tmux.conf..."
    echo "" >> "$TMUX_CONF"
    echo "# Enable focus events for better autoread support" >> "$TMUX_CONF"
    echo "set-option -g focus-events on" >> "$TMUX_CONF"
    echo "✓ Added focus-events to tmux config"
    echo "  (Restart tmux to apply: tmux kill-server && tmux)"
fi

echo ""
echo "Fix 4/5: Installing tree-sitter CLI (optional)..."
if command -v tree-sitter &> /dev/null; then
    echo "✓ tree-sitter already installed"
else
    echo "Installing tree-sitter globally with npm..."
    sudo npm install -g tree-sitter-cli
    echo "✓ tree-sitter installed"
fi

echo ""
echo "Fix 5/5: Disabling unnecessary Neovim providers..."
INIT_FILE="$HOME/.dotfiles/nvim/.config/nvim/lua/config/options.lua"

# Check if providers are already disabled
if grep -q "loaded_ruby_provider" "$INIT_FILE" 2>/dev/null; then
    echo "✓ Providers already configured"
else
    echo "Adding provider disables to options.lua..."
    cat >> "$INIT_FILE" << 'EOF'

-- Disable unused providers to avoid warnings
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
EOF
    echo "✓ Disabled Ruby and Perl providers"
fi

echo ""
echo "========================================="
echo "All Fixes Applied!"
echo "========================================="
echo ""
echo "Summary of changes:"
echo "  ✓ Python packages installed (pynvim, jupytext)"
echo "  ✓ Node.js and npm installed"
echo "  ✓ Tmux focus-events enabled"
echo "  ✓ tree-sitter CLI installed"
echo "  ✓ Unnecessary providers disabled"
echo ""
echo "Next steps:"
echo "  1. Restart tmux: tmux kill-server && tmux"
echo "  2. Restart Neovim: nvim"
echo "  3. Check health: :checkhealth"
echo ""
echo "For project venvs, run this in each project:"
echo "  work <project>"
echo "  pip install pynvim jupytext"
echo ""
