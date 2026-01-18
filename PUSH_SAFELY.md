# Push Dotfiles to GitHub Safely (Excluding Lavoro)

## 🔒 Security Measures in Place

Your dotfiles are configured to **NEVER** commit Lavoro work directories or sensitive files.

### What's Protected

The `.gitignore` file excludes:

1. **Lavoro Work Directories**
   ```
   Lavoro/
   **/Lavoro/
   Documents/Lavoro/
   ~/Documents/Lavoro/
   ```

2. **Python Virtual Environments**
   ```
   venv/
   .venv/
   __pycache__/
   *.pyc
   ```

3. **Sensitive Files**
   ```
   *.pem
   *.key
   id_rsa
   credentials.json
   .env
   ```

4. **Temporary/Cache Files**
   ```
   *.backup
   *.log
   .cache
   ```

---

## ✅ Two-Step Safe Push Process

### Step 1: Verify (Dry Run)
```bash
cd ~/.dotfiles
bash verify-before-push.sh
```

This will:
- ✅ Check .gitignore exists
- ✅ Verify no Lavoro files would be committed
- ✅ Check for Python venv files
- ✅ Scan for sensitive files
- ✅ Show you what would be committed

**Only proceed to Step 2 if all checks pass!**

### Step 2: Push to GitHub
```bash
cd ~/.dotfiles
bash push-to-github.sh
```

This will:
1. Initialize Git repository
2. Add GitHub remote
3. **Run security checks again** (double verification)
4. Show you files to be committed
5. Ask for confirmation
6. Create commit with comprehensive message
7. Push to GitHub

---

## 🛡️ Security Features in push-to-github.sh

The push script has **built-in safety checks**:

### 1. Lavoro File Detection
```bash
if git diff --cached --name-only | grep -i "lavoro" &>/dev/null; then
    echo "❌ ERROR: Lavoro work files detected!"
    echo "❌ ABORTING to prevent committing work files."
    exit 1
fi
```
**Result**: Script will **ABORT** if any Lavoro files are detected.

### 2. Python Venv Warning
```bash
if git diff --cached --name-only | grep -E "(venv/|__pycache__)" &>/dev/null; then
    echo "⚠️  WARNING: Python virtual environment files detected!"
    # Asks for confirmation before continuing
fi
```
**Result**: Script will **WARN** and ask before proceeding.

### 3. File Preview Before Commit
- Shows first 30 files to be committed
- Displays total file count
- Option to view all files
- **Requires explicit confirmation** before pushing

---

## 📋 Quick Start

**Safest method (recommended for first push):**

```bash
# 1. Navigate to dotfiles
cd ~/.dotfiles

# 2. Verify (dry run - no changes made)
bash verify-before-push.sh

# 3. If verification passes, push
bash push-to-github.sh
```

**What to expect during push:**

1. Script shows what will be committed
2. Security checks run automatically
3. You'll see: "✓ No Lavoro work files detected"
4. You'll see: "✓ Security check passed"
5. You'll be asked: "Do you want to commit and push? (y/n)"
6. Type `y` and press Enter
7. Enter GitHub credentials:
   - **Username**: GioZe01
   - **Password**: Personal Access Token (NOT your GitHub password)

---

## 🔑 GitHub Authentication

### You Need a Personal Access Token

GitHub no longer accepts passwords for git operations. You need a token.

#### Generate Token:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Give it a name: "Dotfiles CLI Access"
4. Set expiration: 90 days (or custom)
5. Select scopes:
   - ✅ **repo** (all sub-scopes)
6. Click "Generate token"
7. **COPY THE TOKEN** (you won't see it again!)

#### Use Token:
When the script asks for password, paste your token.

**Tip**: Save token securely in a password manager.

---

## ⚠️ What If Something Goes Wrong?

### If Lavoro Files Are Detected:

```bash
❌ ERROR: Lavoro work files detected in staging area!

The following Lavoro files would be committed:
Documents/Lavoro/hyperdnabert/src/model.py
Documents/Lavoro/anamnesis/train.py

❌ ABORTING to prevent committing work files.
```

**Solution**:
1. Script already aborted (nothing was pushed ✓)
2. Check your `.gitignore` file
3. Verify you're in `~/.dotfiles` directory (not `~/Documents/Lavoro`)
4. Run verification script again

### If You Accidentally Committed Lavoro Files:

**BEFORE PUSHING** (caught by script):
```bash
# Script will abort automatically
# Nothing is pushed to GitHub
# You're safe!
```

**AFTER PUSHING** (worst case):
```bash
# Remove sensitive files from history
cd ~/.dotfiles
git filter-branch --force --index-filter \
  "git rm -rf --cached --ignore-unmatch Documents/Lavoro" \
  --prune-empty --tag-name-filter cat -- --all

# Force push (overwrites GitHub)
git push origin main --force
```

**Better**: Delete the repository on GitHub and start fresh.

---

## 📂 What WILL Be Committed

Only your configuration files:

```
✅ Configuration Files:
   - zsh/.zshrc and .zsh/*.zsh
   - tmux/.tmux.conf
   - nvim/.config/nvim/
   - i3/.config/i3/
   - alacritty/.config/alacritty/
   - git/.gitconfig

✅ Scripts:
   - install.sh
   - scripts/*.sh

✅ Documentation:
   - README.md
   - COMMANDS_*.md
   - *.md files

✅ Config Files:
   - .gitignore
   - *.lua, *.toml, *.conf

❌ NOT Committed:
   - Documents/Lavoro/ (your work projects)
   - venv/ directories
   - __pycache__/
   - *.pyc files
   - Sensitive files
```

---

## 🎯 Expected Output

When everything works correctly:

```
═══════════════════════════════════════════════════════
    Pushing Dotfiles to GitHub
═══════════════════════════════════════════════════════

📂 Working directory: /home/gio/.dotfiles

✓ Remote already configured

✓ .gitignore exists

🔒 Security Check: Verifying no Lavoro work files...

✓ No Lavoro work files detected
✓ Security check passed

📋 Files to be committed:

README.md
COMMANDS_I3.md
COMMANDS_TMUX.md
COMMANDS_ZSH.md
COMMANDS_NVIM.md
... (more files)

Total: 87 files

Do you want to commit and push these changes? (y/n) y

Creating commit...
[main (root-commit) abc1234] Complete dotfiles system with comprehensive command references
 87 files changed, 12543 insertions(+)

Setting branch to main...
✓ Branch set to main

Pushing to GitHub...

Username for 'https://github.com': GioZe01
Password for 'https://GioZe01@github.com': [paste token here]

Enumerating objects: 120, done.
Counting objects: 100% (120/120), done.
Delta compression using up to 8 threads
Compressing objects: 100% (95/95), done.
Writing objects: 100% (120/120), 456.78 KiB | 12.34 MiB/s, done.
Total 120 (delta 18), reused 0 (delta 0)
To https://github.com/GioZe01/.dotfiles.git
 * [new branch]      main -> main

═══════════════════════════════════════════════════════
✓ Success! Dotfiles pushed to GitHub
═══════════════════════════════════════════════════════

View your repository at:
https://github.com/GioZe01/.dotfiles

✅ Verified: No Lavoro work files were committed
✅ Your work projects remain private
```

---

## 🔍 Manual Verification (Extra Safety)

If you want to triple-check before pushing:

```bash
cd ~/.dotfiles

# 1. Show what would be added
git add -n .

# 2. Look for "lavoro" (should return nothing)
git add -n . | grep -i lavoro

# 3. Check .gitignore is working
git status --ignored | grep Lavoro

# 4. See what will be committed
git status
```

---

## ✅ Final Checklist

Before running `push-to-github.sh`:

- [ ] You're in `~/.dotfiles` directory (NOT in `~/Documents/Lavoro`)
- [ ] You ran `verify-before-push.sh` and it passed
- [ ] You have a GitHub Personal Access Token ready
- [ ] You reviewed the security measures above

**Ready to push?**

```bash
cd ~/.dotfiles
bash push-to-github.sh
```

---

## 🎓 Understanding the Protection

### Why Lavoro Won't Be Committed:

1. **Location**: Lavoro is at `~/Documents/Lavoro/`, dotfiles are at `~/.dotfiles/`
   - Different directories = physically separate
   - Git only tracks files in `~/.dotfiles/`

2. **.gitignore**: Even if Lavoro files somehow appeared in dotfiles:
   - `.gitignore` explicitly excludes "Lavoro/" patterns
   - Git will ignore them

3. **Security Checks**: Even if .gitignore failed:
   - Script checks for "lavoro" in staged files
   - Aborts if any are found

4. **Manual Review**: Before final push:
   - You see the file list
   - You must confirm with 'y'

**Four layers of protection = Your work stays private! 🔒**

---

## 📞 Need Help?

If you see any errors or unexpected behavior:

1. **Don't panic** - Script will abort before pushing
2. **Read the error message** - It will tell you what's wrong
3. **Check you're in the right directory**: `pwd` should show `/home/gio/.dotfiles`
4. **Run verification**: `bash verify-before-push.sh`
5. **Review .gitignore**: `cat .gitignore | grep -i lavoro`

**The scripts are designed to fail safely - they'll abort rather than risk pushing sensitive files.**

---

**You're protected! Push confidently. 🚀**
