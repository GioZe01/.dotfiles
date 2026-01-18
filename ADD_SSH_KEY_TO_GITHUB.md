# Add SSH Key to GitHub

## ✅ SSH Key Generated Successfully!

Your SSH key has been generated and configured for GitHub.

---

## 🔑 Your Public SSH Key

**Copy this entire key and add it to GitHub:**

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII/GvVybncg11/S0E2T8P89v3QH6oK5lcQ9YkhEh0+4f giovanni.terzuolo01@gmail.com
```

---

## 📋 Step-by-Step: Add Key to GitHub

### 1. Copy the SSH Key

**Option A: Manual Copy**
```bash
cat ~/.ssh/id_ed25519_github.pub
```
Then select and copy the entire output.

**Option B: Copy to Clipboard (if xclip is installed)**
```bash
cat ~/.ssh/id_ed25519_github.pub | xclip -selection clipboard
```

### 2. Add to GitHub

1. Go to GitHub: https://github.com/settings/keys
2. Click **"New SSH key"** (green button in top right)
3. Fill in the form:
   - **Title**: `Ubuntu Desktop - Dotfiles`
   - **Key type**: `Authentication Key`
   - **Key**: Paste the entire public key (starts with `ssh-ed25519`)
4. Click **"Add SSH key"**
5. Confirm with your GitHub password if prompted

### 3. Test the Connection

```bash
ssh -T git@github.com
```

**Expected output:**
```
Hi GioZe01! You've successfully authenticated, but GitHub does not provide shell access.
```

If you see this, **SSH is working!** ✅

---

## 🚀 Now Push to GitHub

Your repository is already configured to use SSH:

```bash
cd ~/.dotfiles
bash push-to-github.sh
```

**No password required!** SSH will authenticate automatically using your key. 🔐

---

## 🔍 Verify Configuration

Check that SSH is configured:

```bash
# Check remote URL (should show git@github.com)
cd ~/.dotfiles
git remote -v

# Should output:
# origin  git@github.com:GioZe01/.dotfiles.git (fetch)
# origin  git@github.com:GioZe01/.dotfiles.git (push)
```

Check SSH key is loaded:

```bash
ssh-add -l

# Should output:
# 256 SHA256:dINmfqBPvtCiv49cQ4h6kV3D9Q7EjdgnRqQ/o9jD/TE giovanni.terzuolo01@gmail.com (ED25519)
```

---

## 🛠️ What Was Done

1. ✅ Generated ED25519 SSH key pair:
   - Private key: `~/.ssh/id_ed25519_github` (keep this secret!)
   - Public key: `~/.ssh/id_ed25519_github.pub` (add to GitHub)

2. ✅ Added key to ssh-agent for automatic authentication

3. ✅ Created SSH config (`~/.ssh/config`) for GitHub:
   ```
   Host github.com
       IdentityFile ~/.ssh/id_ed25519_github
   ```

4. ✅ Updated git remote to use SSH:
   - Changed from: `https://github.com/GioZe01/.dotfiles.git`
   - Changed to: `git@github.com:GioZe01/.dotfiles.git`

---

## ⚙️ SSH Auto-start (Optional)

To automatically load your SSH key on login, add this to `~/.zshrc`:

```bash
# SSH Agent (auto-start)
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519_github 2>/dev/null
fi
```

Then reload:
```bash
source ~/.zshrc
```

---

## 🔐 Security Notes

### Private Key Security
- **NEVER** share `~/.ssh/id_ed25519_github` (private key)
- **NEVER** commit private keys to Git
- Only share the `.pub` file (public key)

### Key is Protected
Your private key is already in `.gitignore`:
```
# SSH and credentials
*.pem
*.key
id_rsa
id_ed25519
```

### Passphrase (Optional)
If you want extra security, you can add a passphrase to your key:
```bash
ssh-keygen -p -f ~/.ssh/id_ed25519_github
```

---

## 🆘 Troubleshooting

### "Permission denied (publickey)"

**Solution 1: Key not added to GitHub**
- Make sure you added the public key to: https://github.com/settings/keys
- Copy the ENTIRE key including `ssh-ed25519` and email

**Solution 2: SSH agent not running**
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_github
```

**Solution 3: Wrong key file**
```bash
# Verify the key exists
ls -la ~/.ssh/id_ed25519_github*

# Should show both files:
# id_ed25519_github      (private key)
# id_ed25519_github.pub  (public key)
```

### "Bad configuration option: IdentitiesOnly"

Your SSH version might be old. Remove that line from `~/.ssh/config`:
```bash
nvim ~/.ssh/config
# Delete the line: IdentitiesOnly yes
```

### Test Connection Fails

```bash
# Test with verbose output
ssh -vT git@github.com

# Look for:
# - "Offering public key: /home/gio/.ssh/id_ed25519_github"
# - "Server accepts key"
```

---

## 📚 Additional Resources

- GitHub SSH Docs: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
- Troubleshooting: https://docs.github.com/en/authentication/troubleshooting-ssh

---

## ✅ Quick Checklist

Before pushing:

- [ ] SSH key generated (`~/.ssh/id_ed25519_github`)
- [ ] Public key copied
- [ ] Public key added to GitHub (https://github.com/settings/keys)
- [ ] SSH connection tested (`ssh -T git@github.com`)
- [ ] Git remote updated to SSH (`git remote -v` shows `git@github.com`)

**All done?** Push to GitHub:

```bash
cd ~/.dotfiles
bash push-to-github.sh
```

**No password needed! SSH authentication is automatic.** 🎉
