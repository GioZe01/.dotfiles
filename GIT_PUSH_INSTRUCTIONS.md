# Push .dotfiles to GitHub

## 🔒 Security First

**Your Lavoro work directories are protected and will NOT be committed!**

See [PUSH_SAFELY.md](PUSH_SAFELY.md) for detailed security information.

### Quick Security Overview
- ✅ Lavoro directories excluded via `.gitignore`
- ✅ Automated security checks in push script
- ✅ Verification script available (`verify-before-push.sh`)
- ✅ Multiple layers of protection

## Quick Start (Recommended)

### Safest Method with Verification

```bash
# 1. Verify what will be pushed (dry run)
cd ~/.dotfiles
bash verify-before-push.sh

# 2. If verification passes, push to GitHub
bash push-to-github.sh
```

The scripts will automatically handle initialization, security checks, and pushing.

---

## Step-by-Step Instructions (Manual Method)

### 1. Navigate to dotfiles directory
```bash
cd ~/.dotfiles
```

### 2. Initialize Git repository (if not already done)
```bash
# Check if already a git repo
git status

# If not, initialize
git init
```

### 3. Add remote repository
```bash
# Add your GitHub repository as remote
git remote add origin https://github.com/GioZe01/.dotfiles.git

# Verify remote was added
git remote -v
```

### 4. Create .gitignore (to exclude sensitive files)
```bash
cat > .gitignore << 'EOF'
# Ignore backup files
*.backup
*~
.*.swp

# Ignore OS files
.DS_Store
Thumbs.db

# Ignore vim session files
Session.vim

# Ignore compiled files
*.pyc
__pycache__/

# Ignore local config
local/
EOF
```

### 5. Stage all files
```bash
# Add all files
git add .

# Verify what will be committed
git status
```

### 6. Create initial commit
```bash
git commit -m "$(cat <<'EOF'
Initial commit: Complete dotfiles setup

Features:
- i3 window manager with Italian keyboard layout
- Tmux with Ctrl+a prefix and vim bindings
- Zsh with Oh My Zsh and custom Lavoro project functions
- Neovim (ThePrimeagen-style) with LSP, Treesitter, Telescope
- Alacritty terminal with DejaVu Sans Mono font
- Git configuration
- NordVPN integration in i3 status bar
- GPU monitoring in i3 status bar
- Multi-monitor support
- Comprehensive command references for all tools
- Installation scripts with automated setup

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

### 7. Set default branch (if needed)
```bash
# Ensure you're on main branch
git branch -M main
```

### 8. Push to GitHub
```bash
# First push (set upstream)
git push -u origin main

# You may be prompted to authenticate
# Use GitHub username and Personal Access Token (not password)
```

### 9. Verify push was successful
```bash
# Check remote repository
git remote show origin

# Or visit in browser
echo "Visit: https://github.com/GioZe01/.dotfiles"
```

---

## GitHub Authentication

### If Using HTTPS (Recommended)

You'll need a **Personal Access Token** instead of password:

1. Go to GitHub.com → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Select scopes:
   - ✅ repo (all)
   - ✅ workflow
4. Generate token and **save it securely** (you won't see it again)
5. Use token as password when pushing

### If Using SSH

```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "giovanni.terzuolo01@gmail.com"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add SSH key
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
cat ~/.ssh/id_ed25519.pub

# Add to GitHub:
# GitHub.com → Settings → SSH and GPG keys → New SSH key
# Paste the public key

# Change remote to use SSH
git remote set-url origin git@github.com:GioZe01/.dotfiles.git

# Test connection
ssh -T git@github.com

# Push
git push -u origin main
```

---

## Future Updates

After initial push, update dotfiles with:

```bash
cd ~/.dotfiles

# Check what changed
git status

# Stage changes
git add .

# Or stage specific files
git add nvim/.config/nvim/lua/config/keymaps.lua
git add zsh/.zsh/aliases.zsh

# Commit with descriptive message
git commit -m "Update nvim keybindings for better workflow"

# Push to GitHub
git push
```

---

## Useful Git Commands for Dotfiles

```bash
# View commit history
git log --oneline --graph

# See what changed
git diff

# See what's staged
git diff --cached

# Undo staging
git reset HEAD file.txt

# Discard local changes
git checkout -- file.txt

# Amend last commit (before push)
git commit --amend -m "New commit message"

# View remote info
git remote -v

# Pull latest changes
git pull origin main

# Clone on new machine
git clone https://github.com/GioZe01/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

---

## Recommended Commit Message Format

```bash
# Feature addition
git commit -m "Add NordVPN integration to i3 status bar"

# Bug fix
git commit -m "Fix nvim treesitter compatibility with Neovim 0.9.5"

# Configuration update
git commit -m "Update tmux prefix to Ctrl+a for ergonomics"

# Documentation
git commit -m "Add comprehensive Neovim command reference"

# Refactoring
git commit -m "Refactor zsh functions for better modularity"

# Multiple changes
git commit -m "$(cat <<EOF
Update terminal configuration

Changes:
- Switch font to DejaVu Sans Mono for better clarity
- Increase font size to 13pt
- Add high contrast color scheme
- Fix character overlapping issues
EOF
)"
```

---

## Troubleshooting

### Permission Denied (publickey)
```bash
# Check SSH key is added
ssh-add -l

# If not, add it
ssh-add ~/.ssh/id_ed25519

# Test GitHub connection
ssh -T git@github.com
```

### Authentication Failed (HTTPS)
```bash
# Use Personal Access Token instead of password
# Generate at: https://github.com/settings/tokens

# Store credentials (optional, for convenience)
git config --global credential.helper store
# Next push will ask for credentials once, then remember
```

### Repository Already Exists on GitHub
```bash
# If repo exists but is empty, force push
git push -u origin main --force

# If repo has content, pull first
git pull origin main --allow-unrelated-histories
git push -u origin main
```

### Large Files Warning
```bash
# If files > 50MB, use Git LFS
git lfs install
git lfs track "*.large_file_extension"
git add .gitattributes
git commit -m "Track large files with Git LFS"
git push
```

---

## Next Steps After Push

1. **Add README badges** (optional):
   - Add badges for license, stars, forks
   - Add screenshots of setup

2. **Create GitHub Pages** (optional):
   - Showcase your dotfiles with documentation website
   - Enable in repository settings

3. **Set repository description**:
   - Go to repository → About → Add description
   - Example: "Personal dotfiles for i3, tmux, zsh, and neovim (ThePrimeagen-style)"

4. **Add topics** (tags):
   - dotfiles
   - i3wm
   - neovim
   - tmux
   - zsh
   - linux
   - ubuntu

5. **Star your own repo** (to find it easily later)

---

## Verify Everything Was Pushed

```bash
# List all files in repository
git ls-tree -r main --name-only

# Should include:
# - COMMANDS_I3.md
# - COMMANDS_TMUX.md
# - COMMANDS_ZSH.md
# - COMMANDS_NVIM.md
# - README.md
# - install.sh
# - All config directories (zsh, tmux, nvim, i3, alacritty, git)
# - All scripts

# Count files
git ls-tree -r main --name-only | wc -l
```

---

**Ready to push?** Follow steps 1-8 above and your dotfiles will be on GitHub!
