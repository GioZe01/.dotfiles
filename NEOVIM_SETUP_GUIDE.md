# Neovim Complete Setup & Troubleshooting Guide

This guide will help you set up Neovim properly, fix navigation issues, and configure project recognition.

---

## Table of Contents
1. [First-Time Setup](#first-time-setup)
2. [Verify Installation](#verify-installation)
3. [File Navigation Commands](#file-navigation-commands)
4. [Project Recognition](#project-recognition)
5. [Troubleshooting](#troubleshooting)
6. [Testing Your Setup](#testing-your-setup)

---

## First-Time Setup

### Step 1: Install Neovim (if not installed)

```bash
# Check Neovim version (should be 0.9.0+)
nvim --version

# If not installed or version is too old
sudo apt update
sudo apt install neovim

# Or install latest from PPA
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

### Step 2: Apply Dotfiles Configuration

```bash
# Make sure you've stowed the nvim config
cd ~/.dotfiles
stow nvim

# Verify the config is linked
ls -la ~/.config/nvim
# Should show symlink to ~/.dotfiles/nvim/.config/nvim
```

### Step 3: First Launch (Plugin Installation)

**IMPORTANT**: On the first launch, lazy.nvim will automatically install all plugins.

```bash
# Launch Neovim
nvim

# You should see lazy.nvim installing plugins automatically
# Wait for all plugins to install (may take 2-5 minutes)
# You'll see a progress window showing plugin installation

# Once complete, quit and restart
:q
nvim
```

### Step 4: Install LSP Servers

After plugins are installed, you need to install language servers:

```bash
# Open Neovim
nvim

# Open Mason (LSP installer)
:Mason

# Install Python LSP servers (use Tab to navigate, Enter to install)
# Install these:
# - pyright (Python type checking)
# - ruff-lsp (Python linting/formatting)
# - lua-language-server (Lua)
# - bash-language-server (Bash)
# - json-lsp (JSON)

# Or install from command line
:MasonInstall pyright ruff-lsp lua-language-server bash-language-server json-lsp

# Wait for installation to complete
# Press 'q' to close Mason
```

### Step 5: Build Native Extensions

Some plugins need native compilation:

```bash
# Exit Neovim and run
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim
make

# Verify it compiled
ls build/
# Should see libfzf.so
```

### Step 6: Authenticate Codeium (Optional - for AI completion)

```bash
# Open Neovim
nvim

# Run authentication command
:Codeium Auth

# Browser will open
# Sign in with GitHub/Google/GitLab
# Copy the token
# Paste it back in Neovim

# Verify it's working
:Codeium Status
```

---

## Verify Installation

### Check Health

Run health checks to verify everything is working:

```bash
nvim
:checkhealth

# Check specific components
:checkhealth lazy
:checkhealth nvim-treesitter
:checkhealth telescope
:checkhealth lsp
```

### Verify Plugins Loaded

```bash
nvim
:Lazy

# You should see all plugins with a checkmark (✓)
# If any show an 'X', press 'U' to update or 'I' to install
```

### List Installed Plugins

From terminal:
```bash
ls ~/.local/share/nvim/lazy/
# Should include:
# - telescope.nvim
# - harpoon
# - oil.nvim
# - nvim-lspconfig
# - codeium.nvim
# - mason.nvim
```

---

## File Navigation Commands

### Current Status Check

1. **Open Neovim in a directory**:
   ```bash
   cd ~/Documents/Lavoro/hyperdnabert
   nvim
   ```

2. **Try the navigation commands** (in Neovim Normal mode):

### Telescope (Fuzzy Finder)

| Command | Keybinding | What It Does |
|---------|------------|--------------|
| Find files | `<Space>pf` | Fuzzy find files in project |
| Live grep | `<Space>ps` | Search text in all files |
| Git files | `<Space>pg` | Find files tracked by git |
| Buffers | `<Space>pb` | Switch between open buffers |
| Help tags | `<Space>ph` | Search help documentation |
| Recent files | `<Space>pr` | Recently opened files |
| File browser | `<Space>pe` | Browse files with Telescope |

**Testing Telescope**:
```vim
" In Neovim, press in Normal mode:
<Space>pf
" You should see a fuzzy finder window
" Type to search for files
" Press <Esc> to close
```

### Harpoon (Quick File Marks)

| Command | Keybinding | What It Does |
|---------|------------|--------------|
| Add file | `<Space>a` | Mark current file |
| Show menu | `<Space>h` | Show all marked files |
| Go to file 1 | `<Space>1` | Jump to first marked file |
| Go to file 2 | `<Space>2` | Jump to second marked file |
| Go to file 3 | `<Space>3` | Jump to third marked file |
| Go to file 4 | `<Space>4` | Jump to fourth marked file |

**Testing Harpoon**:
```vim
" 1. Open a file
:e src/model.py

" 2. Mark it
<Space>a

" 3. Open another file
:e src/train.py

" 4. Mark it
<Space>a

" 5. Show marked files
<Space>h
" You should see both files in the menu

" 6. Jump between them
<Space>1    " Jump to first file
<Space>2    " Jump to second file
```

### Oil.nvim (File Explorer)

| Command | Keybinding | What It Does |
|---------|------------|--------------|
| Open explorer | `<Space>pv` or `-` | Edit filesystem like buffer |
| Open floating | `<Space>-` | Floating file explorer |

**Testing Oil.nvim**:
```vim
" Press in Normal mode:
<Space>pv

" You should see a file listing
" Navigate with j/k
" Press Enter to open a file or directory
" Press - to go up a directory
" Edit filenames to rename (then :w to save)
" Delete lines with 'dd' to delete files (then :w to apply)
```

### LSP Navigation

| Command | Keybinding | What It Does |
|---------|------------|--------------|
| Go to definition | `gd` | Jump to where symbol is defined |
| Find references | `gr` | Show all references to symbol |
| Hover docs | `K` | Show documentation |
| Code action | `<Space>ca` | Show available code actions |

**Testing LSP**:
```python
# Open a Python file with imports
nvim test.py

# In the file, place cursor on a function name
# Press 'gd' - should jump to definition
# Press 'K' - should show documentation
```

---

## Project Recognition

Neovim recognizes a project by looking for these markers in the directory tree:

### Git Projects (Recommended)

If your directory has a `.git` folder, it's automatically recognized as a project:

```bash
cd ~/Documents/Lavoro/hyperdnabert
ls -la | grep .git
# Should show .git directory

# If no .git directory, initialize one:
git init
```

**Project Root Detection**:
- Telescope searches from git root
- LSP workspace is set to git root
- Harpoon marks are per-project (git root)
- Session files are saved per-project

### Non-Git Projects

For non-git projects, Neovim looks for these markers:
- `.git/`
- `package.json`
- `setup.py`
- `pyproject.toml`
- `Cargo.toml`
- `go.mod`
- `Makefile`

**Create a Project Marker**:

If none of these exist, create a simple marker:

```bash
cd ~/my-project

# Option 1: Initialize git
git init

# Option 2: Create a project file
touch .projectroot

# Option 3: Create pyproject.toml for Python projects
cat > pyproject.toml << EOF
[tool.poetry]
name = "myproject"
version = "0.1.0"
EOF
```

### Set Working Directory

When you open Neovim, it uses the current directory as the working directory:

```bash
# Open from project root
cd ~/Documents/Lavoro/hyperdnabert
nvim

# Check current directory in Neovim
:pwd

# Change directory if needed
:cd ~/Documents/Lavoro/hyperdnabert

# Or use autochdir to follow file location
:set autochdir
```

### Session Management (Per-Project)

Use sessions to save your project state:

```bash
# Start Neovim with session support
nvim

# In your project, start obsession (auto-save session)
:Obsession ~/.vim/sessions/myproject.vim

# Next time, restore the session
nvim -S ~/.vim/sessions/myproject.vim

# Or use the work() function from zsh
worke myproject  # Automatically manages sessions
```

---

## Troubleshooting

### Issue 1: Keybindings Not Working

**Symptom**: Pressing `<Space>pf` does nothing

**Solutions**:

1. **Check leader key**:
   ```vim
   :echo mapleader
   " Should show a space character

   " If not set, your leader is wrong
   " Check ~/.config/nvim/lua/config/options.lua
   ```

2. **Verify plugin loaded**:
   ```vim
   :Lazy
   " Check if telescope.nvim has a checkmark

   " If not loaded, try
   :Lazy sync
   ```

3. **Test keybinding**:
   ```vim
   " Try the command directly
   :Telescope find_files

   " If this works, keybinding issue
   " If this doesn't work, plugin issue
   ```

4. **Check for conflicts**:
   ```vim
   " See what's mapped to <Space>pf
   :map <Space>pf
   ```

### Issue 2: Telescope Shows "No Files Found"

**Solutions**:

1. **Check working directory**:
   ```vim
   :pwd
   " Should be in your project directory

   " Change if needed
   :cd ~/Documents/Lavoro/hyperdnabert
   ```

2. **Check if files exist**:
   ```bash
   # From terminal in same directory
   ls
   find . -type f | head -10
   ```

3. **Try git files instead**:
   ```vim
   " If in a git repo, try
   <Space>pg
   ```

4. **Check ripgrep is installed**:
   ```bash
   which rg
   # Should show path to ripgrep

   # If not installed
   sudo apt install ripgrep
   ```

### Issue 3: Oil.nvim Not Opening

**Solutions**:

1. **Check plugin installation**:
   ```vim
   :Lazy
   " Find oil.nvim - should have checkmark
   ```

2. **Try command directly**:
   ```vim
   :Oil
   " Should open file explorer
   ```

3. **Check keybinding**:
   ```vim
   :map <Space>pv
   " Should show Oil mapping
   ```

### Issue 4: Harpoon Not Working

**Solutions**:

1. **Check harpoon version**:
   ```vim
   :Lazy
   " Find harpoon - should be on 'harpoon2' branch
   ```

2. **Clear harpoon data**:
   ```bash
   rm -rf ~/.local/share/nvim/harpoon
   ```

3. **Test manually**:
   ```vim
   :lua require("harpoon"):list():add()
   " Should add current file

   :lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
   " Should show menu
   ```

### Issue 5: LSP Not Working

**Solutions**:

1. **Check LSP status**:
   ```vim
   :LspInfo
   " Should show attached language servers
   ```

2. **Install language server**:
   ```vim
   :Mason
   " Install pyright, ruff-lsp, etc.
   ```

3. **Restart LSP**:
   ```vim
   :LspRestart
   ```

4. **Check LSP logs**:
   ```vim
   :lua vim.cmd('e '..vim.lsp.get_log_path())
   ```

### Issue 6: Plugins Not Installing

**Solutions**:

1. **Clear lazy cache**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.cache/nvim
   ```

2. **Reinstall plugins**:
   ```vim
   nvim
   :Lazy sync
   " Wait for completion

   :Lazy clean
   :Lazy install
   ```

3. **Check for errors**:
   ```vim
   :Lazy log
   " Look for error messages
   ```

### Issue 7: "Command not found" Errors

**Symptom**: `:Telescope` gives error "Not an editor command"

**Solution**:

```bash
# Delete plugin data and reinstall
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

nvim
# Let lazy.nvim reinstall everything
# Wait 2-5 minutes for completion
```

---

## Testing Your Setup

### Complete Navigation Test

Run this test to verify everything works:

```bash
# 1. Navigate to a project
cd ~/Documents/Lavoro/hyperdnabert

# 2. Open Neovim
nvim

# 3. Test Telescope
# Press: <Space>pf
# You should see: Fuzzy file finder with list of files
# Type a filename and press Enter to open

# 4. Test Oil
# Press: <Space>pv
# You should see: File explorer showing current directory
# Press 'q' or <Esc> to close

# 5. Test Harpoon
# Press: <Space>a (marks current file)
# Open another file: :e another-file.py
# Press: <Space>a (marks this file too)
# Press: <Space>h (shows harpoon menu)
# You should see: List of marked files
# Press: <Space>1 to jump to first file

# 6. Test LSP (in a Python file)
# Place cursor on a function name
# Press: gd
# You should: Jump to the function definition
# Press: K
# You should: See documentation popup

# 7. Test AI Completion (if authenticated)
# Start typing code
# You should: See gray suggestion text appear
# Press: Tab to accept
```

### Quick Diagnostic

Run this in Neovim to check everything:

```vim
" Open Neovim and run
:checkhealth

" Check specific components
:checkhealth telescope
:checkhealth mason
:checkhealth lsp

" List plugins
:Lazy

" Check LSP status
:LspInfo

" Check Codeium status
:Codeium Status
```

---

## Quick Fix Commands

If navigation is broken, try these in order:

```bash
# 1. Make sure you're in a project directory
cd ~/Documents/Lavoro/hyperdnabert

# 2. Verify config is linked
ls -la ~/.config/nvim
# Should show symlink to dotfiles

# 3. Open Neovim and sync plugins
nvim
:Lazy sync
:qall

# 4. Reopen and check health
nvim
:checkhealth

# 5. Test navigation
# Press <Space>pf in Normal mode
```

---

## Daily Workflow

### Starting a Project Session

```bash
# Method 1: Using work() function with session support
worke hyperdnabert
# Opens Neovim with session restoration

# Method 2: Manual
cd ~/Documents/Lavoro/hyperdnabert
nvim
:Obsession ~/.vim/sessions/hyperdnabert.vim
```

### Navigating Files

```vim
" 1. Find files quickly
<Space>pf       " Fuzzy find
" Type filename, press Enter

" 2. Search in files
<Space>ps       " Live grep
" Type search term

" 3. Mark frequently-used files
<Space>a        " Add to harpoon
" Do this for 3-4 main files

" 4. Jump between marked files
<Space>1        " File 1
<Space>2        " File 2
<Space>3        " File 3
<Space>4        " File 4

" 5. Browse filesystem
<Space>pv       " Oil.nvim
" Navigate with j/k, Enter to open
```

### LSP Workflow

```vim
" Jump to definition
gd

" Find all references
gr

" Show documentation
K

" Rename symbol
<Space>rn

" Code actions
<Space>ca

" Format code
<Space>f
```

---

## Configuration Files Reference

```
~/.config/nvim/
├── init.lua                                    # Entry point
└── lua/config/
    ├── lazy.lua                                # Plugin manager config
    ├── options.lua                             # Vim settings (leader key here)
    ├── keymaps.lua                             # Custom keybindings
    └── plugins/
        ├── telescope.lua                       # <Space>pf, <Space>ps, etc.
        ├── harpoon.lua                         # <Space>a, <Space>h, <Space>1-4
        ├── file-explorer.lua                   # <Space>pv, -
        ├── lsp.lua                             # gd, gr, K, etc.
        └── ai-completion.lua                   # Codeium AI
```

---

## Getting Help

If you're still having issues:

1. **Check logs**:
   ```bash
   # Neovim log
   tail -f ~/.local/state/nvim/log

   # LSP log
   nvim
   :lua print(vim.lsp.get_log_path())
   :e /path/from/above
   ```

2. **Minimal config test**:
   ```bash
   # Test with no config
   nvim -u NONE test.txt
   # If this works, config issue
   ```

3. **Verify keybindings**:
   ```vim
   :verbose map <Space>pf
   " Shows where keybinding is defined
   ```

4. **Read documentation**:
   ```bash
   cd ~/.dotfiles
   cat COMMANDS_NEOVIM.md
   cat NEOVIM_SETUP_GUIDE.md
   ```

---

## Summary Checklist

✅ **Before You Start**:
- [ ] Neovim 0.9+ installed
- [ ] Config stowed: `stow nvim`
- [ ] In a project directory (has .git or project marker)

✅ **First Launch**:
- [ ] Opened Neovim: `nvim`
- [ ] Waited for plugin installation (2-5 min)
- [ ] Ran `:checkhealth`
- [ ] Installed LSP servers: `:Mason`

✅ **Test Navigation**:
- [ ] Telescope works: `<Space>pf`
- [ ] Oil.nvim works: `<Space>pv`
- [ ] Harpoon works: `<Space>a` then `<Space>h`
- [ ] LSP works: `gd` on a function

✅ **Project Setup**:
- [ ] Directory has `.git` or project marker
- [ ] Working directory is correct: `:pwd`
- [ ] Session saved: `:Obsession ~/.vim/sessions/project.vim`

---

**Note**: If you just pulled the latest dotfiles, you MUST open Neovim to let it install the new plugins (harpoon, oil.nvim, codeium, etc.) on first launch. This is automatic and only happens once.
