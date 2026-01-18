#!/bin/bash

# Verify what will be pushed to GitHub (dry run)
# This script checks without actually committing or pushing

echo "═══════════════════════════════════════════════════════"
echo "    Dotfiles Push Verification (Dry Run)"
echo "═══════════════════════════════════════════════════════"
echo ""

cd ~/.dotfiles || { echo "Error: ~/.dotfiles not found"; exit 1; }

echo "📂 Working directory: $(pwd)"
echo ""

# Check .gitignore
echo "🔍 Checking .gitignore..."
if [ -f ".gitignore" ]; then
    echo "✓ .gitignore exists"
    echo ""
    echo "Lavoro exclusions in .gitignore:"
    grep -i "lavoro" .gitignore || echo "  (none found - may need to add)"
    echo ""
else
    echo "❌ .gitignore NOT found!"
    echo "Please create .gitignore before pushing."
    exit 1
fi

# Simulate staging
echo "📋 Simulating git add..."
git add -n . > /tmp/git-add-simulation.txt 2>&1

# Check for Lavoro files
echo ""
echo "🔒 Security Check: Looking for Lavoro files..."
if grep -i "lavoro" /tmp/git-add-simulation.txt &>/dev/null; then
    echo "❌ WARNING: Lavoro files would be added:"
    echo ""
    grep -i "lavoro" /tmp/git-add-simulation.txt
    echo ""
    echo "❌ DO NOT PUSH until these are excluded in .gitignore"
    rm /tmp/git-add-simulation.txt
    exit 1
else
    echo "✓ No Lavoro files detected"
fi

# Check for Python venv files
echo ""
echo "🐍 Checking for Python virtual environment files..."
if grep -E "(venv/|__pycache__|\.pyc)" /tmp/git-add-simulation.txt &>/dev/null; then
    echo "⚠️  Python venv files detected:"
    echo ""
    grep -E "(venv/|__pycache__|\.pyc)" /tmp/git-add-simulation.txt
    echo ""
    echo "⚠️  These should be excluded in .gitignore"
else
    echo "✓ No venv files detected"
fi

# Check for sensitive files
echo ""
echo "🔐 Checking for sensitive files..."
SENSITIVE_PATTERNS="(\.pem|\.key|id_rsa|id_ed25519|credentials\.json|secrets\.json|\.env)"
if grep -E "$SENSITIVE_PATTERNS" /tmp/git-add-simulation.txt &>/dev/null; then
    echo "❌ SENSITIVE FILES DETECTED:"
    echo ""
    grep -E "$SENSITIVE_PATTERNS" /tmp/git-add-simulation.txt
    echo ""
    echo "❌ DO NOT PUSH - Add these to .gitignore immediately!"
    rm /tmp/git-add-simulation.txt
    exit 1
else
    echo "✓ No sensitive files detected"
fi

echo ""
echo "═══════════════════════════════════════════════════════"

# List files that would be committed
echo ""
echo "📄 Files that would be committed:"
echo ""
git status --short 2>/dev/null || git ls-files -o --exclude-standard | head -50

echo ""
echo "Total files: $(git ls-files -o --exclude-standard 2>/dev/null | wc -l)"

rm /tmp/git-add-simulation.txt

echo ""
echo "═══════════════════════════════════════════════════════"
echo "✅ Verification Complete"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "If all checks passed, you can safely run:"
echo "  bash push-to-github.sh"
echo ""
