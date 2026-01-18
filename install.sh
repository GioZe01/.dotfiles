#!/bin/bash

# Main installation script for dotfiles setup
# Orchestrates the entire installation process

set -e

DOTFILES_DIR="$HOME/.dotfiles"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt (Y/n) "
    else
        prompt="$prompt (y/N) "
    fi

    read -p "$prompt" -n 1 -r
    echo

    if [ "$default" = "y" ]; then
        [[ $REPLY =~ ^[Nn]$ ]] && return 1 || return 0
    else
        [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
    fi
}

print_header "Dotfiles Installation"

echo "This script will set up your dotfiles system including:"
echo "  • Zsh configuration"
echo "  • Tmux configuration"
echo "  • Neovim (ThePrimeagen-style)"
echo "  • i3 window manager with multi-monitor support"
echo "  • Alacritty terminal with Ctrl+C/V copy/paste"
echo "  • Git configuration"
echo "  • Python virtual environments for Lavoro projects"
echo ""

# Check dependencies
print_header "Checking Dependencies"

if ! command -v git &> /dev/null; then
    print_error "git is not installed"
    exit 1
fi
print_success "git found"

if ! command -v python3 &> /dev/null; then
    print_error "python3 is not installed"
    exit 1
fi
print_success "python3 found ($(python3 --version))"

# Backup existing configs
print_header "Backing Up Existing Configurations"

if ask_yes_no "Backup existing dotfiles?"; then
    chmod +x "$SCRIPTS_DIR/backup-existing.sh"
    "$SCRIPTS_DIR/backup-existing.sh"
    print_success "Backup complete"
else
    print_warning "Skipping backup"
fi

# Install system packages
print_header "System Package Installation"

if ask_yes_no "Install system packages (zsh, tmux, neovim, i3, etc.)?"; then
    chmod +x "$SCRIPTS_DIR/install-packages.sh"
    "$SCRIPTS_DIR/install-packages.sh"
    print_success "System packages installed"
else
    print_warning "Skipping system package installation"
    echo "Note: You'll need zsh, tmux, neovim, and i3 installed for full functionality"
fi

# Install GNU Stow
print_header "Installing GNU Stow"

if ! command -v stow &> /dev/null; then
    echo "GNU Stow is required for symlink management"
    if ask_yes_no "Install GNU Stow?" "y"; then
        sudo apt update
        sudo apt install -y stow
        print_success "GNU Stow installed"
    else
        print_error "GNU Stow is required. Exiting."
        exit 1
    fi
else
    print_success "GNU Stow already installed"
fi

# Stow dotfiles
print_header "Creating Symlinks with GNU Stow"

cd "$DOTFILES_DIR"

STOW_PACKAGES=("zsh" "tmux" "nvim" "i3" "git" "alacritty")

for package in "${STOW_PACKAGES[@]}"; do
    echo "Stowing $package..."
    if stow -v "$package" 2>&1 | grep -q "CONFLICT"; then
        print_warning "Conflicts detected for $package"
        echo "You may need to remove existing files or use the backup"
    else
        stow "$package"
        print_success "$package symlinks created"
    fi
done

# Install Oh My Zsh (optional)
print_header "Oh My Zsh Installation"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    if ask_yes_no "Install Oh My Zsh? (Optional, adds plugins/themes)"; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed"
    else
        print_warning "Skipping Oh My Zsh"
    fi
else
    print_success "Oh My Zsh already installed"
fi

# Install TPM (Tmux Plugin Manager)
print_header "Tmux Plugin Manager"

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    print_success "TPM installed"
    echo "Run 'prefix + I' in tmux to install plugins"
else
    print_success "TPM already installed"
fi

# Setup Python virtual environments
print_header "Python Virtual Environments"

if ask_yes_no "Setup Python virtual environments for Lavoro projects?"; then
    chmod +x "$SCRIPTS_DIR/setup-python-envs.sh"
    "$SCRIPTS_DIR/setup-python-envs.sh"
    print_success "Python environments setup complete"
else
    print_warning "Skipping Python environment setup"
fi

# Configure Italian keyboard layout
print_header "Italian Keyboard Configuration"

echo "Configuring Italian keyboard layout..."
chmod +x "$SCRIPTS_DIR/set-italian-keyboard.sh"
"$SCRIPTS_DIR/set-italian-keyboard.sh"
print_success "Italian keyboard configured"

# Set i3 as default desktop session
print_header "Default Desktop Session"

echo "Setting i3 as default desktop session..."
chmod +x "$SCRIPTS_DIR/set-i3-default.sh"
"$SCRIPTS_DIR/set-i3-default.sh"
print_success "i3 set as default desktop"

# Change default shell to zsh
print_header "Default Shell"

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    print_success "Default shell changed to zsh"
    print_warning "You'll need to log out and back in for this to take effect"
else
    print_success "Default shell is already zsh"
fi

# Final summary
print_header "Installation Complete!"

echo "Configuration Summary:"
echo "  ✓ Zsh configured as default shell"
echo "  ✓ i3 set as default desktop session"
echo "  ✓ Italian keyboard layout configured"
echo "  ✓ Multi-monitor support enabled"
echo "  ✓ Alacritty terminal with Ctrl+C/V"
echo ""
echo "Next steps:"
echo ""
echo "1. Log out and back in to apply all changes"
echo "   - You'll automatically boot into i3 window manager"
echo "   - Zsh will be your default shell"
echo "   - Italian keyboard layout will be active"
echo ""
echo "2. First time in i3:"
echo "   - Press Mod+Return (Super+Enter) to open Alacritty terminal"
echo "   - Press Mod+d to open application launcher (rofi)"
echo ""
echo "3. Launch Neovim - plugins will auto-install on first run:"
echo "   $ nvim"
echo ""
echo "4. Test Python environments:"
echo "   $ work hyperdnabert"
echo ""
echo "5. In tmux, press 'Ctrl+a + I' to install plugins"
echo ""
echo "6. To switch back to GNOME (if needed):"
echo "   At login screen, click gear icon and select 'GNOME'"
echo ""

print_success "Dotfiles installed successfully!"
echo ""
echo "Press any key to continue..."
read -n 1 -s
