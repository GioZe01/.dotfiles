#!/bin/bash

# Backup existing dotfiles before stow overwrites them
# Creates timestamped backup directory

set -e

BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# List of files/directories to backup
BACKUP_ITEMS=(
    ".zshrc"
    ".zsh"
    ".tmux.conf"
    ".tmux"
    ".config/nvim"
    ".config/i3"
    ".config/i3status"
    ".config/alacritty"
    ".gitconfig"
    ".gitignore_global"
)

BACKED_UP=0

for item in "${BACKUP_ITEMS[@]}"; do
    if [ -e "$HOME/$item" ]; then
        echo "Backing up: ~/$item"
        # Create parent directory structure in backup
        parent_dir=$(dirname "$item")
        if [ "$parent_dir" != "." ]; then
            mkdir -p "$BACKUP_DIR/$parent_dir"
        fi
        cp -r "$HOME/$item" "$BACKUP_DIR/$item"
        BACKED_UP=$((BACKED_UP + 1))
    fi
done

if [ $BACKED_UP -eq 0 ]; then
    echo "No existing dotfiles found to backup"
    rmdir "$BACKUP_DIR" 2>/dev/null || true
else
    echo "Backed up $BACKED_UP items to: $BACKUP_DIR"
fi
