# Tmux - Complete Command Reference

## Core Concepts
- **Prefix Key**: `Ctrl+a` (changed from default `Ctrl+b` for ergonomics)
- **Session**: A collection of windows (like a workspace)
- **Window**: A full-screen view (like a browser tab)
- **Pane**: A split section within a window
- **Notation**: `Prefix` means press `Ctrl+a`, release, then press the next key

---

## Getting Started

### Start Tmux
```bash
# Start new session
tmux

# Start new session with name
tmux new -s project-name

# List sessions
tmux ls

# Attach to last session
tmux attach

# Attach to specific session
tmux attach -t project-name

# Kill session
tmux kill-session -t project-name
```

**Auto-start**: Tmux automatically starts when you open a new terminal (configured in `.zshrc`).

---

## Session Management

### Session Commands (Inside Tmux)
| Keybinding | Action |
|------------|--------|
| `Prefix d` | Detach from session (session keeps running) |
| `Prefix $` | Rename current session |
| `Prefix s` | Show session list (interactive switcher) |
| `Prefix (` | Switch to previous session |
| `Prefix )` | Switch to next session |

### Session Commands (From Shell)
```bash
# List all sessions
tmux ls

# Create new session in background
tmux new-session -d -s background-work

# Attach to session
tmux attach -t session-name

# Kill all sessions
tmux kill-server

# Kill specific session
tmux kill-session -t session-name

# Rename session from outside
tmux rename-session -t old-name new-name
```

---

## Window Management (Tabs)

### Window Commands
| Keybinding | Action |
|------------|--------|
| `Prefix c` | Create new window |
| `Prefix ,` | Rename current window |
| `Prefix &` | Kill current window (with confirmation) |
| `Prefix n` | Next window |
| `Prefix p` | Previous window |
| `Prefix 0-9` | Switch to window 0-9 |
| `Prefix w` | Show window list (interactive) |
| `Prefix l` | Toggle between last two windows |
| `Prefix f` | Find window by name |

### Window Organization
```bash
# Create window with name
Prefix c
Prefix , (then type name)

# Create window with specific command
:new-window -n "logs" "tail -f /var/log/syslog"

# Move window to different position
:move-window -t 3

# Swap windows
:swap-window -s 2 -t 1
```

---

## Pane Management (Splits)

### Creating Panes
| Keybinding | Action |
|------------|--------|
| `Prefix %` | Split pane vertically (left/right) |
| `Prefix "` | Split pane horizontally (top/bottom) |
| `Prefix -` | Split pane horizontally (custom binding) |
| `Prefix |` | Split pane vertically (custom binding) |

### Navigating Panes (Vim-style)
| Keybinding | Action |
|------------|--------|
| `Prefix h` | Move to pane on the left |
| `Prefix j` | Move to pane below |
| `Prefix k` | Move to pane above |
| `Prefix l` | Move to pane on the right |
| `Prefix ;` | Toggle between last two panes |
| `Prefix o` | Cycle through panes |
| `Prefix q` | Show pane numbers (then press number to jump) |

### Pane Control
| Keybinding | Action |
|------------|--------|
| `Prefix x` | Kill current pane (with confirmation) |
| `Prefix !` | Break pane into new window |
| `Prefix z` | Toggle pane zoom (fullscreen/restore) |
| `Prefix Ctrl+o` | Rotate panes forward |
| `Prefix Alt+o` | Rotate panes backward |
| `Prefix {` | Swap with previous pane |
| `Prefix }` | Swap with next pane |
| `Prefix Space` | Cycle through pane layouts |

### Resizing Panes
| Keybinding | Action |
|------------|--------|
| `Prefix H` (Shift+h) | Resize pane left |
| `Prefix J` (Shift+j) | Resize pane down |
| `Prefix K` (Shift+k) | Resize pane up |
| `Prefix L` (Shift+l) | Resize pane right |

**Alternative**: Hold `Prefix` and press arrow keys repeatedly.

---

## Copy Mode (Vim-style)

### Enter Copy Mode
| Keybinding | Action |
|------------|--------|
| `Prefix [` | Enter copy mode |
| `Prefix PgUp` | Enter copy mode and scroll up |

### Navigation in Copy Mode
| Key | Action |
|-----|--------|
| `h/j/k/l` | Move cursor (Vim-style) |
| `w/b` | Forward/backward one word |
| `0/$` | Start/end of line |
| `g/G` | Top/bottom of buffer |
| `Ctrl+u/d` | Scroll up/down half page |
| `Ctrl+b/f` | Scroll up/down full page |
| `/` | Search forward |
| `?` | Search backward |
| `n/N` | Next/previous search result |

### Copy and Paste
| Key | Action |
|-----|--------|
| `Space` | Start selection |
| `Enter` | Copy selection and exit copy mode |
| `Prefix ]` | Paste last copied text |
| `v` | Toggle visual selection mode |
| `V` | Toggle line selection mode |
| `Escape` or `q` | Exit copy mode |

**System Clipboard**: Use `y` to copy to system clipboard (requires tmux-yank plugin).

---

## Command Mode

### Enter Command Mode
| Keybinding | Action |
|------------|--------|
| `Prefix :` | Enter command mode |

### Useful Commands
```tmux
# Set option
:set -g mouse on

# Source config file (reload)
:source-file ~/.tmux.conf

# List all keybindings
:list-keys

# List all commands
:list-commands

# Show all options
:show-options -g

# Create window with command
:new-window -n "htop" "htop"

# Split and run command
:split-window -h "htop"

# Rename window
:rename-window "new-name"

# Resize pane to specific size
:resize-pane -t 1 -x 80
:resize-pane -t 1 -y 20

# Move pane to new window
:break-pane -t :2
```

---

## Plugin Management (TPM)

### Installed Plugins
1. **tmux-sensible**: Sane default settings
2. **tmux-resurrect**: Save/restore sessions
3. **tmux-continuum**: Auto-save sessions every 15 minutes
4. **tmux-yank**: Enhanced copy to system clipboard

### Plugin Commands
| Keybinding | Action |
|------------|--------|
| `Prefix I` | Install new plugins (capital I) |
| `Prefix U` | Update plugins (capital U) |
| `Prefix alt+u` | Uninstall plugins not in config |

### tmux-resurrect (Save/Restore)
| Keybinding | Action |
|------------|--------|
| `Prefix Ctrl+s` | Save current session |
| `Prefix Ctrl+r` | Restore saved session |

**Auto-save**: Sessions automatically save every 15 minutes (tmux-continuum).

**What's saved**: Window layouts, pane contents, working directories, running programs.

---

## Configuration

### Config File
- **Location**: `~/.tmux.conf`
- **Edit**: `nvim ~/.tmux.conf`
- **Reload**: `Prefix r` or `tmux source-file ~/.tmux.conf`

### Custom Settings in This Config
```bash
# Prefix key changed to Ctrl+a
set-option -g prefix C-a

# Mouse support enabled
set -g mouse on

# Vi mode for copy
set-window-option -g mode-keys vi

# Start window numbering at 1
set -g base-index 1

# Start pane numbering at 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Increase history limit
set -g history-limit 50000

# Display time for pane indicators
set -g display-panes-time 2000

# Display time for status messages
set -g display-time 2000

# Faster command sequences (no delay)
set -s escape-time 0
```

---

## Workflow Examples

### Development Workflow
```bash
# Start session for project
tmux new -s myproject

# Create windows for different tasks
Prefix c                    # Window 0: Editor
Prefix , (name: "nvim")
nvim

Prefix c                    # Window 1: Server
Prefix , (name: "server")
python manage.py runserver

Prefix c                    # Window 2: Tests
Prefix , (name: "tests")

Prefix c                    # Window 3: Git
Prefix , (name: "git")

# Split test window for watching tests
Prefix 2                    # Go to window 2
Prefix %                    # Vertical split
# Left pane: pytest --watch
# Right pane: logs

# Detach and reattach later
Prefix d
# ... work on something else ...
tmux attach -t myproject
```

### Multi-Pane Setup
```bash
# Start with one pane
tmux new -s coding

# Create 4-pane layout
Prefix "                    # Horizontal split (top/bottom)
Prefix %                    # Split top pane vertically
Prefix k                    # Move to top
Prefix k                    # Move to top-left
Prefix %                    # Split top-left vertically

# Result: 4 panes (2 on top, 2 on bottom)
# Use Prefix Space to cycle layouts
```

### Session for Each Project
```bash
# Create project sessions
tmux new -s hyperdnabert -d
tmux new -s anamnesis -d
tmux new -s prism -d
tmux new -s cgkt -d

# Quick switch between projects
Prefix s                    # Show session list
# Or from shell:
tmux attach -t hyperdnabert

# Detach and switch
Prefix d
tmux attach -t anamnesis
```

---

## Pair Programming / Remote Sessions

### Share Session
```bash
# Host creates session
tmux new -s pair-session

# Remote user attaches (read-write)
ssh user@host
tmux attach -t pair-session

# Both users see and control the same session
```

### Read-Only Sharing
```bash
# Remote user attaches read-only
tmux attach -t pair-session -r
```

---

## Status Bar

### Status Bar Sections
```
[Session: main] [0:zsh 1:nvim* 2:server-] ... [battery] [time] [date]
```

- `*` = Current window
- `-` = Last window
- `#` = Activity in window

### Customize Status Bar
```tmux
# Show/hide status bar
:set -g status on
:set -g status off

# Status bar position
:set -g status-position top
:set -g status-position bottom

# Update interval (seconds)
:set -g status-interval 1

# Custom status right
:set -g status-right '#(whoami)@#H'
```

---

## Advanced Features

### Synchronized Panes
```bash
# Enable synchronized input to all panes
:setw synchronize-panes on

# Type in one pane, appears in all
# Useful for: running same command on multiple servers

# Disable
:setw synchronize-panes off
```

### Tmux Scripting
```bash
# Create complex layout via script
tmux new-session -d -s dev -n editor
tmux send-keys -t dev:editor 'nvim' C-m
tmux new-window -t dev -n server
tmux send-keys -t dev:server 'python server.py' C-m
tmux split-window -t dev:server -h
tmux send-keys -t dev:server.1 'tail -f logs/server.log' C-m
tmux attach -t dev
```

### Capture Pane Content
```bash
# Capture pane to file
:capture-pane -S - -E -
:save-buffer ~/pane-capture.txt

# Or from shell
tmux capture-pane -t session:window.pane -p > output.txt
```

---

## Troubleshooting

### Colors Look Wrong
```bash
# Check if 256 colors are supported
echo $TERM
# Should be: screen-256color or tmux-256color

# Force 256 colors in tmux.conf
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

### Prefix Not Working
```bash
# Check prefix key
tmux show-options -g | grep prefix
# Should show: prefix C-a

# List all key bindings
tmux list-keys
```

### Copy Mode Not Working
```bash
# Check if vi mode is enabled
tmux show-options -g | grep mode-keys
# Should show: mode-keys vi

# Manually enable
:set-window-option -g mode-keys vi
```

### Session Not Saving
```bash
# Manually save session
Prefix Ctrl+s

# Check resurrect directory
ls ~/.tmux/resurrect/

# Restore manually
Prefix Ctrl+r
```

---

## Tips & Best Practices

1. **Session Naming**: Use descriptive names for sessions
   - Good: `tmux new -s web-dev`
   - Bad: `tmux new -s 1`

2. **Window Organization**: Keep related tasks in same session
   - Window 0: Editor
   - Window 1: Terminal
   - Window 2: Server/Logs
   - Window 3: Database

3. **Pane Layouts**: Don't create too many panes
   - Maximum 4 panes per window
   - Use windows instead of cramming panes

4. **Detach Frequently**: Tmux sessions persist
   - `Prefix d` to detach
   - Sessions run in background
   - `tmux attach` to return

5. **Use Zoom**: Full-screen a pane temporarily
   - `Prefix z` to zoom in
   - `Prefix z` again to zoom out

6. **Copy Mode**: Navigate history efficiently
   - `Prefix [` to enter
   - Use Vim keys (j/k, gg, G, /)
   - `Space` to select, `Enter` to copy

7. **Save Sessions**: Before reboots
   - `Prefix Ctrl+s` to save
   - Auto-restored on tmux start

---

## Quick Reference Card

```
SESSION:
Prefix d                → Detach
Prefix $                → Rename session
Prefix s                → List sessions

WINDOWS:
Prefix c                → New window
Prefix ,                → Rename window
Prefix n/p              → Next/previous window
Prefix 0-9              → Switch to window
Prefix w                → List windows

PANES:
Prefix %                → Vertical split
Prefix "                → Horizontal split
Prefix h/j/k/l          → Navigate panes (Vim)
Prefix x                → Kill pane
Prefix z                → Zoom pane
Prefix Space            → Cycle layouts
Prefix H/J/K/L          → Resize pane

COPY MODE:
Prefix [                → Enter copy mode
Space                   → Start selection
Enter                   → Copy selection
Prefix ]                → Paste
q                       → Exit copy mode

SYSTEM:
Prefix :                → Command mode
Prefix r                → Reload config
Prefix ?                → List keybindings
Prefix I                → Install plugins
Prefix Ctrl+s           → Save session
Prefix Ctrl+r           → Restore session
```

---

## Integration with This Dotfiles Setup

### Auto-start on Terminal Open
- Configured in `~/.zshrc`
- Automatically creates or attaches to "main" session
- Disable: Comment out tmux auto-start in `.zshrc`

### Plugin Auto-install
- TPM automatically installs on first tmux start
- Plugins install with `Prefix I`

### Color Scheme Integration
- Matches Alacritty retro color scheme
- DejaVu Sans Mono font rendering
- High contrast for readability

---

**Note**: After making changes to `~/.tmux.conf`, reload with `Prefix r` or `tmux source-file ~/.tmux.conf`.
