#!/bin/bash

# Quick installation script - run this with: bash INSTALL_NOW.sh

set -e

cd ~/.dotfiles

echo "========================================="
echo "Installing Dotfiles System"
echo "========================================="
echo ""

# Install GNU Stow
echo "1. Installing GNU Stow..."
sudo apt update
sudo apt install -y stow

# Install all packages
echo ""
echo "2. Installing system packages..."
echo "   (zsh, tmux, neovim, i3, alacritty, etc.)"
sudo apt install -y \
    zsh tmux neovim git curl wget \
    i3 i3status i3lock rofi picom feh arandr alacritty \
    ripgrep fd-find fzf build-essential \
    fonts-firacode \
    python3-pip python3-venv

# Stow all configurations
echo ""
echo "3. Creating symlinks with GNU Stow..."
cd ~/.dotfiles
stow -R zsh tmux nvim i3 git alacritty

# Install Oh My Zsh
echo ""
echo "4. Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Oh My Zsh plugins
echo ""
echo "5. Installing Oh My Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || true

# Install TPM
echo ""
echo "6. Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Setup Python environments
echo ""
echo "7. Setting up Python virtual environments..."
bash scripts/setup-python-envs.sh

# Configure Italian keyboard
echo ""
echo "8. Configuring Italian keyboard layout..."
bash scripts/set-italian-keyboard.sh

# Set i3 as default
echo ""
echo "9. Setting i3 as default desktop session..."
bash scripts/set-i3-default.sh

# Change default shell
echo ""
echo "10. Changing default shell to zsh..."
chsh -s $(which zsh)

echo ""
echo "========================================="
echo "✓ INSTALLATION COMPLETE!"
echo "========================================="
echo ""
echo "Configuration applied:"
echo "  ✓ Italian keyboard layout"
echo "  ✓ i3 as default desktop (multi-monitor support)"
echo "  ✓ Zsh as default shell"
echo "  ✓ Alacritty terminal with Ctrl+C/V"
echo "  ✓ Neovim (ThePrimeagen config)"
echo "  ✓ Tmux with plugins"
echo "  ✓ Python venvs for Lavoro projects"
echo ""
echo "NEXT: Log out and log back in"
echo "      You'll boot directly into i3!"
echo ""
echo "i3 Quick Start:"
echo "  - Mod+Return: Open terminal (Alacritty)"
echo "  - Mod+d: Application launcher"
echo "  - Mod+Shift+q: Close window"
echo "  - Mod is the Windows/Super key"
echo ""
