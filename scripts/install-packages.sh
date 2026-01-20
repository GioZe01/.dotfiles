#!/bin/bash

# Install all required system packages for the dotfiles setup

set -e

echo "Installing system packages..."
echo "This will use sudo and may prompt for your password."
echo ""

# Package list
PACKAGES=(
    # Core tools
    "zsh"
    "tmux"
    "neovim"
    "git"
    "curl"
    "wget"

    # i3 window manager and related tools
    "i3"
    "i3status"
    "i3lock"
    "rofi"
    "picom"
    "feh"
    "arandr"
    "alacritty"
    "kitty"

    # Development tools
    "ripgrep"
    "fd-find"
    "fzf"
    "build-essential"

    # Fonts
    "fonts-firacode"

    # Python development
    "python3-pip"
    "python3-venv"
    "python3-dev"

    # Data Science & ML dependencies
    "libreadline-dev"       # For molten-nvim (Lua compilation)
    "nodejs"                # For markdown-preview.nvim
    "npm"                   # For markdown-preview.nvim
    "imagemagick"           # For image.nvim
    "libmagickwand-dev"     # For image processing

    # Bioinformatics (optional)
    # bioSyntax must be installed separately - see DATASCIENCE_NEOVIM.md
)

echo "Will install the following packages:"
printf '%s\n' "${PACKAGES[@]}"
echo ""

read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Update package list
sudo apt update

# Install packages
sudo apt install -y "${PACKAGES[@]}"

echo ""
echo "Package installation complete!"
