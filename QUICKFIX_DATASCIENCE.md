# Quick Fix: Data Science Plugin Installation Errors

If you're seeing errors like "readline/readline.h: No such file or directory" or "command not found: npm", follow these steps to fix them.

## Current Errors

The following plugins were failing to install:
- ✗ **molten-nvim** - Missing `libreadline-dev` (FIXED - now disabled by default)
- ✗ **image.nvim** - Treesitter dependency conflict (FIXED - removed duplicate dependency)
- ✗ **markdown-preview.nvim** - Missing `npm` (FIXED - now disabled by default)
- ✗ **nvim-treesitter** - Dependency loading loop (FIXED - cleaned up dependencies)

## Quick Fix (Recommended)

### Step 1: Install Missing System Dependencies

```bash
sudo apt update
sudo apt install -y libreadline-dev nodejs npm python3-dev kitty imagemagick libmagickwand-dev
```

### Step 2: Clean Neovim Cache

```bash
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/share/nvim/site
rm -rf ~/.cache/nvim
```

### Step 3: Restart Neovim

The plugins are now disabled by default, so they won't cause errors:

```bash
nvim
```

Neovim will start normally. The data science plugins are disabled until you're ready to use them.

### Step 4: When Ready, Enable Data Science Features

```bash
cd ~/.dotfiles
./scripts/setup-datascience.sh
```

This will:
1. Install all Python packages needed
2. Optionally install bioSyntax
3. Enable the plugins
4. Setup Jupyter kernels

## Alternative: Manual Fix

If you want to fix and enable plugins manually:

### Fix molten-nvim

```bash
# Install dependencies
sudo apt install libreadline-dev python3-dev
pip install pynvim jupyter jupyter_client cairosvg pnglatex plotly kaleido

# Enable in Neovim config
nvim ~/.dotfiles/nvim/.config/nvim/lua/config/plugins/datascience.lua
# Change line 12: enabled = false -> enabled = true
```

### Fix markdown-preview.nvim

```bash
# Install npm
sudo apt install nodejs npm

# Enable in Neovim config
nvim ~/.dotfiles/nvim/.config/nvim/lua/config/plugins/datascience.lua
# Change line 137: enabled = false -> enabled = true

# Rebuild plugin
nvim
:Lazy build markdown-preview.nvim
```

### Fix image.nvim

```bash
# Install Kitty terminal
sudo apt install kitty imagemagick

# Enable in Neovim config
nvim ~/.dotfiles/nvim/.config/nvim/lua/config/plugins/datascience.lua
# Change line 55: enabled = false -> enabled = true
```

## Verify Installation

After fixing, verify everything works:

```bash
# Start Neovim
nvim

# Check plugin status
:Lazy

# All plugins should show as loaded (green checkmark)
```

## Test Data Science Features

### Test Jupyter Integration

```bash
# Create test file
nvim test.py
```

In Neovim:
```python
# %%
import numpy as np
print("Hello from Jupyter!")

# %%
data = np.random.randn(10)
print(data)
```

Then:
1. Press `<leader>mi` to initialize Molten
2. Press `<leader>ml` to run current line
3. Output should appear inline

### Test work -e Command

```bash
# Navigate to project with Neovim auto-open
work -e anamnesis

# Neovim should open with:
# - Project directory
# - Python venv activated
# - Session restored (if exists)
```

### Test Terminal Integration

In Neovim:
- `<leader>t1` - Toggle general terminal
- `<leader>t2` - Toggle testing terminal
- `<leader>ct` - Open Claude in terminal

## Still Having Issues?

### Check System Dependencies

```bash
# Verify all deps installed
dpkg -l | grep -E 'libreadline-dev|nodejs|npm|kitty|imagemagick'
```

### Check Python Packages

```bash
# Verify Python packages
pip list | grep -E 'jupyter|pynvim|matplotlib|numpy'
```

### Check Neovim Version

```bash
# Data science plugins require Neovim 0.9+
nvim --version
```

### Get Detailed Logs

```bash
# Start Neovim with verbose logging
nvim --startuptime startup.log
cat startup.log

# Check plugin manager logs
nvim
:Lazy log
```

## Disabling Features You Don't Need

If you don't need certain features, you can leave them disabled:

**Don't need Jupyter?**
- Leave `molten-nvim` disabled (enabled = false)

**Don't need image viewing?**
- Leave `image.nvim` disabled

**Don't need markdown preview?**
- Leave `markdown-preview.nvim` disabled

**Only want basic CSV/Python support?**
- The following work without extra dependencies:
  - `venv-selector.nvim` - Python venv management
  - `jupytext.nvim` - Edit .ipynb as .py
  - `csv.vim` - CSV viewing
  - `vim-dadbod-ui` - Database client

## Summary

1. **Immediate fix**: Plugins are now disabled by default - no more errors
2. **When ready**: Run `./scripts/setup-datascience.sh` to enable them
3. **Manual control**: Edit `datascience.lua` to enable only what you need

For full documentation, see [DATASCIENCE_NEOVIM.md](DATASCIENCE_NEOVIM.md)
