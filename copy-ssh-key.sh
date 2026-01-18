#!/bin/bash

# Copy SSH public key to clipboard or display it

echo "═══════════════════════════════════════════════════════"
echo "    GitHub SSH Public Key"
echo "═══════════════════════════════════════════════════════"
echo ""

SSH_KEY_FILE="$HOME/.ssh/id_ed25519_github.pub"

if [ ! -f "$SSH_KEY_FILE" ]; then
    echo "❌ SSH key not found at: $SSH_KEY_FILE"
    echo ""
    echo "Generate one first:"
    echo "  ssh-keygen -t ed25519 -C \"giovanni.terzuolo01@gmail.com\""
    exit 1
fi

echo "Your SSH public key:"
echo ""
echo "─────────────────────────────────────────────────────"
cat "$SSH_KEY_FILE"
echo "─────────────────────────────────────────────────────"
echo ""

# Try to copy to clipboard
if command -v xclip &> /dev/null; then
    cat "$SSH_KEY_FILE" | xclip -selection clipboard
    echo "✓ Key copied to clipboard!"
    echo ""
elif command -v xsel &> /dev/null; then
    cat "$SSH_KEY_FILE" | xsel --clipboard --input
    echo "✓ Key copied to clipboard!"
    echo ""
else
    echo "ℹ️  Install xclip to auto-copy:"
    echo "   sudo apt install xclip"
    echo ""
fi

echo "Next steps:"
echo "1. Go to: https://github.com/settings/keys"
echo "2. Click 'New SSH key'"
echo "3. Title: Ubuntu Desktop - Dotfiles"
echo "4. Paste the key above"
echo "5. Click 'Add SSH key'"
echo ""
echo "Then test the connection:"
echo "  ssh -T git@github.com"
echo ""
