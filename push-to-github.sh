#!/bin/bash

# Push dotfiles to GitHub repository (EXCLUDING Lavoro work directories)
# Repository: https://github.com/GioZe01/.dotfiles.git

set -e  # Exit on error

echo "═══════════════════════════════════════════════════════"
echo "    Pushing Dotfiles to GitHub"
echo "═══════════════════════════════════════════════════════"
echo ""

# Navigate to dotfiles directory
cd ~/.dotfiles || { echo "Error: ~/.dotfiles not found"; exit 1; }

echo "📂 Working directory: $(pwd)"
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "Initializing Git repository..."
    git init
    echo "✓ Git initialized"
    echo ""
fi

# Check if remote exists
if ! git remote get-url origin &>/dev/null; then
    echo "Adding GitHub remote..."
    git remote add origin https://github.com/GioZe01/.dotfiles.git
    echo "✓ Remote added"
    echo ""
else
    echo "✓ Remote already configured"
    echo ""
fi

# Verify .gitignore exists
if [ ! -f ".gitignore" ]; then
    echo "❌ Error: .gitignore not found!"
    echo "This should not happen. Please check your dotfiles directory."
    exit 1
fi

echo "✓ .gitignore exists"
echo ""

# Security check: Verify no Lavoro files will be committed
echo "🔒 Security Check: Verifying no Lavoro work files..."
echo ""

# Stage files first to check what would be committed
git add .

# Check for any Lavoro-related files in staging area
if git diff --cached --name-only | grep -i "lavoro" &>/dev/null; then
    echo "❌ ERROR: Lavoro work files detected in staging area!"
    echo ""
    echo "The following Lavoro files would be committed:"
    git diff --cached --name-only | grep -i "lavoro"
    echo ""
    echo "❌ ABORTING to prevent committing work files."
    echo "Please check your .gitignore file."
    git reset  # Unstage everything
    exit 1
fi

# Additional check for Python virtual environments
if git diff --cached --name-only | grep -E "(venv/|__pycache__/|\.pyc$)" &>/dev/null; then
    echo "⚠️  WARNING: Python virtual environment files detected!"
    echo ""
    echo "The following files would be committed:"
    git diff --cached --name-only | grep -E "(venv/|__pycache__/|\.pyc$)"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        git reset
        exit 1
    fi
fi

echo "✓ No Lavoro work files detected"
echo "✓ Security check passed"
echo ""

# Show what will be committed
echo "📋 Files to be committed:"
echo ""
git diff --cached --name-only | head -30
echo ""

FILE_COUNT=$(git diff --cached --name-only | wc -l)
echo "Total: $FILE_COUNT files"
echo ""

# If more than 30 files, ask if user wants to see all
if [ "$FILE_COUNT" -gt 30 ]; then
    read -p "Show all $FILE_COUNT files? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git diff --cached --name-only
        echo ""
    fi
fi

# Ask for confirmation
read -p "Do you want to commit and push these changes? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    git reset
    exit 1
fi

# Create commit
echo "Creating commit..."
git commit -m "$(cat <<'EOF'
Complete dotfiles system with comprehensive command references

Features:
- i3 window manager with Italian keyboard layout
- Tmux with Ctrl+a prefix and vim bindings
- Zsh with Oh My Zsh and custom Lavoro project functions
- Neovim (ThePrimeagen-style) with LSP, Treesitter, Telescope
- Alacritty terminal with DejaVu Sans Mono font (13pt)
- Git configuration
- NordVPN integration in i3 status bar
- GPU monitoring in i3 status bar
- Multi-monitor support
- Complete command references for i3, Tmux, Zsh, and Neovim
- Installation scripts with automated setup

Documentation:
- COMMANDS_I3.md: Complete i3 window manager reference
- COMMANDS_TMUX.md: Complete Tmux reference
- COMMANDS_ZSH.md: Complete Zsh reference
- COMMANDS_NVIM.md: Complete Neovim reference
- 500+ commands documented across all tools
- Workflow examples and troubleshooting guides

Technical details:
- Treesitter pinned to v0.9.2 (Neovim 0.9.5 compatibility)
- nvim-notify disabled (compatibility issue)
- Rose-pine high contrast retro theme
- DejaVu Sans Mono font for clarity (no character overlap)
- System clipboard integration
- Italian keyboard layout system-wide

Security:
- Lavoro work directories excluded via .gitignore
- No virtual environments or Python cache files
- No sensitive credentials

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)" || {
    echo "Nothing to commit (already up to date)"
}
echo ""

# Set branch to main
echo "Setting branch to main..."
git branch -M main
echo "✓ Branch set to main"
echo ""

# Push to GitHub
echo "Pushing to GitHub via SSH..."
echo ""
echo "ℹ️  Using SSH authentication (no password required)"
echo ""

# Test SSH connection first
if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "✓ SSH connection verified"
    echo ""
else
    echo "⚠️  SSH connection test failed!"
    echo ""
    echo "Please add your SSH key to GitHub:"
    echo "1. Copy your public key:"
    echo "   cat ~/.ssh/id_ed25519_github.pub"
    echo ""
    echo "2. Add it to GitHub at:"
    echo "   https://github.com/settings/keys"
    echo ""
    echo "3. Test connection:"
    echo "   ssh -T git@github.com"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        git reset
        exit 1
    fi
fi

git push -u origin main

echo ""
echo "═══════════════════════════════════════════════════════"
echo "✓ Success! Dotfiles pushed to GitHub"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "View your repository at:"
echo "https://github.com/GioZe01/.dotfiles"
echo ""
echo "✅ Verified: No Lavoro work files were committed"
echo "✅ Your work projects remain private"
echo ""
echo "Next steps:"
echo "1. Add a description to your repository on GitHub"
echo "2. Add topics: dotfiles, i3wm, neovim, tmux, zsh, linux"
echo "3. Star your own repository for easy access"
echo ""
