# Neovim Navigation - Quick Start Card

**Essential keybindings to get you started with file navigation**

---

## Leader Key = SPACE

Press `Space` then the command. All keybindings start with Space.

---

## File Navigation (Must Know)

### Telescope (Fuzzy Finder)
```
Space + pf    →  Find files (most useful!)
Space + ps    →  Search text in all files (grep)
Space + pg    →  Git files only
Space + pb    →  Switch between open buffers
Space + pr    →  Recent files
```

### File Explorer (Oil.nvim)
```
Space + pv    →  Open file explorer
-             →  Open parent directory
```

**In file explorer**:
- `j/k` - Navigate up/down
- `Enter` - Open file or directory
- `-` - Go to parent directory
- `dd` - Delete file (then `:w` to apply)
- Edit line to rename file (then `:w` to apply)

---

## Quick File Marks (Harpoon)

**For files you edit frequently** (game changer!)

```
Space + a     →  Add current file to marks
Space + h     →  Show all marked files
Space + 1     →  Jump to file 1
Space + 2     →  Jump to file 2
Space + 3     →  Jump to file 3
Space + 4     →  Jump to file 4
```

**Workflow**:
1. Open your main file → `Space + a` (mark it)
2. Open another file → `Space + a` (mark it)
3. Now instantly jump between them with `Space + 1` and `Space + 2`

---

## Code Navigation (LSP)

**Must be in a Python/code file**:

```
gd            →  Go to definition
gr            →  Find all references
K             →  Show documentation
Space + ca    →  Code actions (fixes/refactors)
Space + rn    →  Rename variable/function
Space + f     →  Format code
```

---

## AI Completion (Codeium)

```
Tab           →  Accept AI suggestion
Alt + ]       →  Next suggestion
Alt + [       →  Previous suggestion
Space + ai    →  Open AI chat
Space + ae    →  Toggle AI on/off
```

**First time**: `:Codeium Auth` (authenticate once)

---

## Common Tasks

### Finding a File
```vim
1. Press: Space + pf
2. Type: part of filename
3. Press: Enter to open
```

### Searching for Text
```vim
1. Press: Space + ps
2. Type: search term
3. Press: Enter to jump to result
```

### Marking Frequently-Used Files
```vim
" Open model.py
1. Press: Space + a

" Open train.py
2. Press: Space + a

" Now switch instantly:
Space + 1    " Jump to model.py
Space + 2    " Jump to train.py
```

### Browsing Files
```vim
1. Press: Space + pv
2. Navigate with j/k
3. Press Enter to open file
4. Press - to go up a directory
```

---

## First-Time Setup

### 1. Open Neovim (installs plugins automatically)
```bash
nvim
# Wait 2-5 minutes for plugin installation
# Then quit: :q
```

### 2. Install Python LSP Servers
```bash
nvim
:Mason
# Use Tab/Enter to install:
# - pyright (type checking)
# - ruff-lsp (linting/formatting)
# - bash-language-server
```

### 3. Install Missing Dependency
```bash
sudo apt install fd-find
```

### 4. Authenticate Codeium (optional - for AI)
```vim
nvim
:Codeium Auth
# Browser opens, sign in, paste token back
```

---

## Troubleshooting

### Navigation not working?

```bash
# Run diagnostic
~/.dotfiles/scripts/nvim-diagnostic.sh

# Common fixes:
cd ~/your-project
nvim
:Lazy sync        # Sync plugins
:Mason            # Install LSP servers
:checkhealth      # Check what's wrong
```

### Specific Issues

**"No files found" in Telescope**:
```vim
:pwd              " Check you're in right directory
:cd ~/your-project " Change to project root
Space + pf        " Try again
```

**Keybindings don't work**:
```vim
:Telescope find_files    " Try direct command
# If this works, plugin is fine, check keybinding
# If this fails, run :Lazy sync
```

**LSP not working (gd, K, etc.)**:
```vim
:LspInfo          " Check if LSP attached
:Mason            " Install language servers
:LspRestart       " Restart LSP
```

---

## Project Setup

Neovim detects projects by looking for:
- `.git/` (most common)
- `pyproject.toml`
- `package.json`
- Or any standard project file

**If no project marker**:
```bash
cd ~/my-project
git init          # Creates .git folder
# OR
touch .projectroot  # Manual marker
```

---

## Daily Workflow

### Starting Work
```bash
# Method 1: With session support
worke myproject

# Method 2: Manual
cd ~/Documents/Lavoro/myproject
nvim
```

### Finding & Editing Files
```vim
" 1. Find the file
Space + pf
" Type filename, press Enter

" 2. Mark important files
Space + a        " Do this for 3-4 main files

" 3. Jump between marked files
Space + 1        " Main file
Space + 2        " Test file
Space + 3        " Config file
Space + 4        " Utils file

" 4. Search for code
Space + ps
" Type what you're looking for

" 5. Navigate code
gd               " Jump to definition
gr               " Find all uses
K                " See documentation
```

---

## Getting Help

```vim
" In Neovim:
:help telescope
:help lsp
:checkhealth

" Read guides:
" ~/.dotfiles/COMMANDS_NEOVIM.md
" ~/.dotfiles/NEOVIM_SETUP_GUIDE.md
```

---

## Remember

1. **Space is your friend** - Almost everything starts with Space
2. **Mark your files** - Use Harpoon (Space+a) for files you edit often
3. **Telescope for everything** - Space+pf for files, Space+ps for search
4. **LSP for code** - gd, K, gr for navigating code
5. **In a git repo?** - Everything works better with git init

---

**Most Common Commands**:
```
Space + pf    →  Find any file (USE THIS!)
Space + ps    →  Search any text
Space + a     →  Mark this file
Space + h     →  Show marked files
Space + 1-4   →  Jump to marked files
gd            →  Go to definition
K             →  Show docs
```

Start with these and you'll be productive immediately!
