#!/bin/bash

# Set i3 as the default desktop session

set -e

echo "Setting i3 as default desktop session..."

# Create .dmrc file to set default session
cat > "$HOME/.dmrc" << 'EOF'
[Desktop]
Session=i3
EOF

chmod 644 "$HOME/.dmrc"

# Also update accountsservice if available
if [ -f "/var/lib/AccountsService/users/$USER" ]; then
    sudo bash -c "cat > /var/lib/AccountsService/users/$USER" << EOF
[User]
Session=i3
Icon=/home/$USER/.face
SystemAccount=false
EOF
fi

echo "✓ i3 set as default desktop session"
echo "  You'll automatically log into i3 on next login"
