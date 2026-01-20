# Dotfiles

Comprehensive dotfiles system using GNU Stow for symlink management. Includes configurations for Zsh, Tmux, Neovim (ThePrimeagen-style), i3wm, and Git, with Python environment management for Lavoro projects.

## 📚 Complete Command References

Comprehensive guides for every tool in this setup:

- **[i3 Window Manager Commands](COMMANDS_I3.md)** - Complete keybinding reference with multi-monitor support, NordVPN integration, and GPU monitoring
- **[Tmux Commands](COMMANDS_TMUX.md)** - Session, window, and pane management with Vim-style navigation
- **[Zsh Commands](COMMANDS_ZSH.md)** - Shell functions, aliases, and Lavoro project management
- **[Neovim Commands](COMMANDS_NVIM.md)** - ThePrimeagen-style keybindings, LSP, Telescope, and plugin commands
- **[Data Science & ML Guide](DATASCIENCE_NEOVIM.md)** - Jupyter, PyTorch, bioinformatics, and ML workflows in Neovim

**Bonus Guides**:
- [Work Command Guide](WORK_COMMAND_GUIDE.md) - Dynamic project management with custom shortcuts
- [Status Bar Changes](STATUSBAR_CHANGES.md) - Interactive volume control and customizations
- [Health Check Fixes](HEALTHCHECK_FIXES.md) - Fix all Neovim health check warnings
- [Data Science Quick Fix](QUICKFIX_DATASCIENCE.md) - Fix plugin installation errors
- [Git Push Instructions](GIT_PUSH_INSTRUCTIONS.md) - How to push these dotfiles to GitHub
- [Add SSH Key to GitHub](ADD_SSH_KEY_TO_GITHUB.md) - SSH authentication setup (no passwords!)
- [Push Safely Guide](PUSH_SAFELY.md) - Security measures to protect Lavoro work files
- [i3 Keybindings Quick Reference](I3_KEYBINDINGS.md) - One-page i3 cheat sheet
- [NordVPN & GPU Setup](NORDVPN_GPU_SETUP.md) - VPN and GPU monitoring configuration
- [Font & Colors Setup](FONT_AND_COLORS_SETUP.md) - Terminal and editor theming details

## Quick Start

```bash
cd ~/.dotfiles
./install.sh
```

The installation script will guide you through the setup process with interactive prompts.

## What's Included

### Shell (Zsh)
- **Modular configuration** split into separate files (aliases, functions, keybindings, etc.)
- **Python environment management** with `work()` functions for Lavoro projects
- **Oh My Zsh** support (optional)
- **FZF integration** for fuzzy finding
- **Custom prompt** with git branch info

### Terminal Multiplexer (Tmux)
- **Prefix key**: `Ctrl+a` (more ergonomic than default `Ctrl+b`)
- **Vim-like navigation** for panes and windows
- **Mouse support** enabled
- **TPM (Tmux Plugin Manager)** with sensible defaults
- **Persistent sessions** with tmux-resurrect and tmux-continuum

### Editor (Neovim)
- **ThePrimeagen-inspired** configuration
- **Lazy.nvim** plugin manager with auto-bootstrap
- **LSP support** for Python (pyright), Lua, Rust, TypeScript via Mason
- **Telescope** for fuzzy finding files and grep
- **Treesitter** for advanced syntax highlighting (pinned to v0.9.2 for Neovim 0.9.5)
- **Rose-pine color scheme** with high contrast retro theme
- **DejaVu Sans Mono** font in GUI mode for consistency
- **Persistent undo** with undotree visualization
- **Fugitive** for Git integration
- **Zen mode** for distraction-free coding
- **Integrated terminal** with toggleterm.nvim (multiple persistent terminals)
- **Testing framework** with neotest for Python/pytest
- **Session management** with vim-obsession (per-project sessions)
- **Claude Code integration** for AI-assisted development
- **Leader key**: Space

### Data Science & Machine Learning (Neovim)
- **Jupyter integration** with molten.nvim and jupytext (edit .ipynb as .py)
- **Image viewing** in terminal with image.nvim (requires Kitty terminal)
- **PyTorch tensor visualization** with dispy.nvim (optional)
- **Bioinformatics** syntax highlighting with bioSyntax (FASTQ, FASTA, SAM, VCF, etc.)
- **Python venv management** with venv-selector.nvim
- **CSV/TSV viewing** with column alignment
- **Database client** for SQL queries (vim-dadbod-ui)
- **Markdown preview** for documentation
- **Enhanced work() function** with `-e` flag to auto-open Neovim with session

### Terminal (Alacritty)
- **Ctrl+C and Ctrl+V** for copy/paste (not Ctrl+Shift)
- **GPU-accelerated** rendering
- **DejaVu Sans Mono** font (13pt) for maximum clarity and readability
- **High contrast retro color scheme** (deep black background, light gray text)
- **No character overlapping** with proper font spacing
- **Configurable** via TOML

### Window Manager (i3)
- **Alternative desktop session** (keeps GNOME installed, or set as default)
- **Italian keyboard layout** configured system-wide
- **Multi-monitor support** with automatic detection and workspace movement
- **Vim-like keybindings** for window management (Windows key + h/j/k/l)
- **NordVPN integration** with toggle and server selection keybindings
- **GPU monitoring** in status bar (utilization, temperature, memory)
- **Enhanced status bar** showing VPN status, GPU stats, volume control, and system info
- **Interactive volume control** in status bar (click to mute, scroll to adjust)
- **Rofi** application launcher
- **Picom** compositor for visual effects
- **Arandr** for GUI monitor configuration

### Version Control (Git)
- **Comprehensive aliases** for common operations
- **Pretty log formats** with colors
- **Global gitignore** for common files
- **Sensible defaults** configured

### Python Environments
- **Automated venv creation** for Lavoro projects
- **Shell functions** for quick project switching
- **work()** function to navigate and activate environments

## System Requirements

- **OS**: Ubuntu 24.04 or later
- **Required packages**: git, python3, stow
- **Optional packages**: zsh, tmux, neovim, i3, rofi, picom, feh

The installation script will offer to install all required packages automatically.

## File Structure

```
.dotfiles/
├── README.md                           # This file
├── install.sh                          # Main installation script
├── scripts/
│   ├── install-packages.sh             # Install system packages
│   ├── setup-python-envs.sh            # Setup Python virtual environments
│   ├── backup-existing.sh              # Backup existing dotfiles
│   └── check-dependencies.sh           # Check for required dependencies
├── zsh/
│   ├── .zshrc                          # Main Zsh config
│   └── .zsh/
│       ├── aliases.zsh                 # Command aliases
│       ├── functions.zsh               # Shell functions (work, etc.)
│       ├── completion.zsh              # Completion settings
│       ├── history.zsh                 # History configuration
│       ├── keybindings.zsh             # Key bindings
│       ├── options.zsh                 # Zsh options
│       └── prompt.zsh                  # Custom prompt
├── tmux/
│   └── .tmux.conf                      # Tmux configuration
├── nvim/
│   └── .config/nvim/
│       ├── init.lua                    # Entry point
│       └── lua/config/
│           ├── lazy.lua                # Plugin manager bootstrap
│           ├── options.lua             # Vim options
│           ├── keymaps.lua             # Key mappings
│           ├── autocmds.lua            # Autocommands
│           └── plugins/                # Plugin configurations
│               ├── telescope.lua       # Fuzzy finder
│               ├── treesitter.lua      # Syntax highlighting
│               ├── lsp.lua             # Language servers
│               ├── fugitive.lua        # Git integration
│               ├── undotree.lua        # Undo visualization
│               ├── zen-mode.lua        # Distraction-free mode
│               ├── colorscheme.lua     # Color scheme
│               ├── ui.lua              # UI plugins
│               └── utils.lua           # Utility plugins
├── i3/
│   ├── .config/i3/config               # i3 window manager config
│   ├── .config/i3status/config         # Status bar config
│   └── .config/i3/scripts/
│       ├── monitor-setup.sh            # Auto-detect monitors
│       └── setup-terminal.sh           # Terminal configuration
├── alacritty/
│   └── .config/alacritty/
│       └── alacritty.toml              # Alacritty terminal config
└── git/
    ├── .gitconfig                      # Git configuration
    └── .gitignore_global               # Global gitignore
```

## Installation

### Automated Installation (Recommended)

```bash
cd ~/.dotfiles
./install.sh
```

The script will:
1. Backup existing dotfiles
2. Install system packages (with confirmation)
3. Install GNU Stow
4. Create symlinks for all configurations
5. Install plugin managers (Oh My Zsh, TPM, lazy.nvim)
6. Setup Python virtual environments for Lavoro projects
7. Configure Italian keyboard layout system-wide
8. Set i3 as default desktop session
9. Change default shell to Zsh

### Manual Installation

If you prefer to install components individually:

#### 1. Install GNU Stow

```bash
sudo apt update
sudo apt install stow
```

#### 2. Stow Individual Packages

```bash
cd ~/.dotfiles

# Stow all packages
stow zsh tmux nvim i3 git

# Or stow individually
stow zsh      # Creates ~/.zshrc and ~/.zsh/
stow tmux     # Creates ~/.tmux.conf
stow nvim     # Creates ~/.config/nvim/
stow i3       # Creates ~/.config/i3/
stow git      # Creates ~/.gitconfig
```

#### 3. Install System Packages

```bash
./scripts/install-packages.sh
```

Or manually:

```bash
sudo apt install zsh tmux neovim git \
  i3 i3status i3lock rofi picom feh \
  ripgrep fd-find fzf fonts-firacode \
  python3-pip python3-venv
```

#### 4. Setup Python Environments

```bash
./scripts/setup-python-envs.sh
```

#### 5. Change Default Shell

```bash
chsh -s $(which zsh)
```

Log out and back in for the change to take effect.

## Python Environment Management

### Quick Navigation with `work()` Function

The `work()` function allows you to quickly navigate to Lavoro projects and activate their virtual environments:

```bash
# Navigate to project and activate venv
work hyperdnabert     # or work-hdb
work anamnesis        # or work-ana
work prism_sr_hdnabert # or work-prism
work cgkt             # or work-cgkt

# Navigate and auto-open Neovim with session (NEW!)
work -e hyperdnabert  # or: worke hyperdnabert
```

This will:
1. Change to the project directory
2. Activate the Python virtual environment
3. Open Neovim with the project session restored
4. All your files, splits, and cursor positions are saved

### Recreate Virtual Environment

If a virtual environment is broken:

```bash
cd ~/Documents/Lavoro/hyperdnabert
recreate-venv
```

This will:
1. Remove the old venv
2. Create a new venv
3. Upgrade pip
4. Install the project with `pip install -e .`

### List Lavoro Projects

```bash
lavoro-ls
```

## Using i3 Window Manager

### Switching to i3

1. Log out of GNOME
2. At the login screen, click the gear icon
3. Select "i3" from the list
4. Log in

### Basic i3 Keybindings

**Modifier key**: `Super` (Windows key)

| Key Combo | Action |
|-----------|--------|
| `Mod+Return` | Open terminal (Alacritty) |
| `Mod+d` | Launch rofi (application launcher) |
| `Mod+Tab` | Window switcher |
| `Mod+Shift+q` | Kill window |
| `Mod+h/j/k/l` | Navigate windows (vim-style) |
| `Mod+Shift+h/j/k/l` | Move windows |
| `Mod+1-9` | Switch to workspace 1-9 |
| `Mod+Shift+1-9` | Move window to workspace 1-9 |
| `Mod+Ctrl+h/j/k/l` | Move workspace to different monitor |
| `Mod+m` / `Mod+Shift+m` | Focus left/right monitor |
| `Mod+p` | Launch arandr (monitor configuration) |
| `Mod+f` | Toggle fullscreen |
| `Mod+r` | Resize mode |
| `Mod+Shift+r` | Restart i3 |
| `Mod+Shift+e` | Exit i3 |
| `Mod+Shift+x` | Lock screen |

### Switching Back to GNOME

At the login screen, select "GNOME" instead of "i3".

### Multi-Monitor Setup

**Automatic Detection**: Monitors are automatically detected and configured on startup.

**Manual Configuration**: Press `Mod+p` to launch Arandr for GUI-based monitor configuration.

**Moving Workspaces**: Use `Mod+Ctrl+h/j/k/l` (or arrow keys) to move the current workspace to a different monitor.

**Focusing Monitors**: Use `Mod+m` and `Mod+Shift+m` to switch focus between monitors.

## Alacritty Terminal

### Copy and Paste

**Ctrl+C**: Copy selected text (or send SIGINT if no selection)
**Ctrl+V**: Paste from clipboard
**Ctrl+Shift+C**: Copy (always works)
**Ctrl+Shift+V**: Paste (always works)

### Other Shortcuts

| Key Combo | Action |
|-----------|--------|
| `Ctrl+Plus` / `Ctrl+Minus` | Increase/decrease font size |
| `Ctrl+0` | Reset font size |
| `Ctrl+Shift+F` | Search |
| `Shift+PageUp/Down` | Scroll |

## Neovim Key Mappings

### Leader Key: `Space`

### File Navigation
- `<leader>pv` - Open file explorer
- `<leader>pf` - Find files (Telescope)
- `<leader>ps` - Live grep (Telescope)
- `<leader>pb` - Find buffers (Telescope)
- `<leader>pg` - Git files (Telescope)

### LSP
- `gd` - Go to definition
- `gr` - Show references
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>f` - Format buffer
- `[d` / `]d` - Previous/next diagnostic

### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gd` - Git diff

### Utilities
- `<leader>u` - Toggle undotree
- `<leader>z` - Toggle Zen mode
- `<leader>e` - Toggle file explorer
- `<C-d>` / `<C-u>` - Scroll down/up (centered)
- `<leader>y` - Yank to system clipboard
- `<leader>s` - Search and replace word under cursor

## Post-Installation

### 1. Install Tmux Plugins

```bash
tmux
# Then press: Ctrl+a + I (capital i)
```

### 2. Install Neovim Plugins

```bash
nvim
# Plugins will auto-install on first launch
# Or manually: :Lazy sync
```

### 3. Install LSP Servers

```bash
nvim
:Mason
# Select and install language servers
```

### 4. Set Up i3 Wallpaper (Optional)

```bash
mkdir -p ~/Pictures
# Copy your wallpaper to ~/Pictures/wallpaper.jpg
# Or edit ~/.config/i3/config to change the wallpaper path
```

### 5. Configure Multi-Monitor Setup (Optional)

If the automatic monitor detection doesn't work perfectly:

```bash
# Use arandr for GUI configuration
arandr

# Or use xrandr commands directly
xrandr --output HDMI-1 --auto --right-of eDP-1
```

Save your configuration in arandr and it will be applied on startup.

### 6. Configure Oh My Zsh Plugins (Optional)

If you installed Oh My Zsh, install additional plugins:

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Then reload Zsh:

```bash
exec zsh
```

### 7. Setup Data Science & ML Features (Optional)

If you want to use Jupyter, PyTorch, or bioinformatics tools in Neovim:

```bash
cd ~/.dotfiles
./scripts/setup-datascience.sh
```

This will:
- Install Python packages (jupyter, pynvim, matplotlib, etc.)
- Optionally install bioSyntax for bioinformatics files
- Enable data science plugins in Neovim
- Setup Jupyter kernels

**Note**: Some plugins (molten.nvim, image.nvim) are disabled by default because they require additional dependencies. The setup script will help you enable them.

For manual setup and detailed guide, see [DATASCIENCE_NEOVIM.md](DATASCIENCE_NEOVIM.md).

## Updating

### Update Dotfiles

```bash
cd ~/.dotfiles
git pull
```

### Re-stow Packages

If you modified configurations:

```bash
cd ~/.dotfiles
stow -R zsh tmux nvim i3 git
```

### Update Plugins

**Neovim**:
```vim
:Lazy update
```

**Tmux**:
```bash
# In tmux: Ctrl+a + U
```

## Uninstall

### Remove Symlinks

```bash
cd ~/.dotfiles
stow -D zsh tmux nvim i3 git
```

### Restore Backups

Backups are stored in `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`

```bash
# Find your backup
ls -la ~ | grep dotfiles-backup

# Restore (example)
cp -r ~/.dotfiles-backup-20260118-120000/.zshrc ~/
```

### Change Shell Back to Bash

```bash
chsh -s /bin/bash
```

## Troubleshooting

### Stow Conflicts

If stow reports conflicts, you may have existing files:

```bash
# Backup the conflicting file
mv ~/.zshrc ~/.zshrc.old

# Try stowing again
cd ~/.dotfiles
stow zsh
```

### Broken Python Virtual Environments

Recreate them:

```bash
cd ~/.dotfiles
./scripts/setup-python-envs.sh
```

Or individually:

```bash
work hyperdnabert
recreate-venv
```

### Neovim Plugins Not Installing

```bash
# Remove lazy.nvim data
rm -rf ~/.local/share/nvim/lazy

# Reopen nvim
nvim
```

### i3 Not Appearing at Login

```bash
# Verify i3 is installed
which i3

# Check for i3 session file
ls /usr/share/xsessions/i3.desktop

# Reinstall if missing
sudo apt install i3
```

## Customization

### Changing Zsh Theme

Edit `~/.zshrc`:

```bash
ZSH_THEME="robbyrussell"  # Change to your preferred theme
```

### Adding Custom Aliases

Edit `~/.zsh/aliases.zsh` and reload:

```bash
exec zsh
```

### Changing Neovim Colorscheme

Edit `~/.config/nvim/lua/config/plugins/colorscheme.lua`

### Modifying i3 Keybindings

Edit `~/.config/i3/config` and reload:

```bash
# In i3: Mod+Shift+r
```

## Credits

- **Neovim configuration** inspired by [ThePrimeagen](https://github.com/ThePrimeagen)
- **GNU Stow** for elegant dotfile management
- **lazy.nvim** plugin manager by [folke](https://github.com/folke/lazy.nvim)
- **Oh My Zsh** by the community

## License

MIT License - Feel free to use and modify as needed.
