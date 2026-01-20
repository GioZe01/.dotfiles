# i3 Window Manager - Complete Command Reference

## Core Concepts
- **Mod Key**: Windows key (⊞) / Super key
- **Movement**: Vim-style (h=left, j=down, k=up, l=right)
- **Workspaces**: Virtual desktops numbered 1-10
- **Containers**: Windows grouped together
- **Modes**: Normal, resize, passthrough

---

## Window Management

### Focus Navigation
| Keybinding | Action |
|------------|--------|
| `Mod+h` | Focus window to the left |
| `Mod+j` | Focus window below |
| `Mod+k` | Focus window above |
| `Mod+l` | Focus window to the right |
| `Mod+a` | Focus parent container |
| `Mod+Space` | Toggle focus between tiling/floating |

### Window Movement
| Keybinding | Action |
|------------|--------|
| `Mod+Shift+h` | Move window left |
| `Mod+Shift+j` | Move window down |
| `Mod+Shift+k` | Move window up |
| `Mod+Shift+l` | Move window right |

### Window Control
| Keybinding | Action |
|------------|--------|
| `Mod+Shift+q` | Kill focused window |
| `Mod+f` | Toggle fullscreen mode |
| `Mod+Shift+Space` | Toggle floating/tiling mode |
| `Mod+Shift+r` | Restart i3 in place (reload config) |
| `Mod+Shift+e` | Exit i3 (logout prompt) |

### Window Layout
| Keybinding | Action |
|------------|--------|
| `Mod+s` | Stacking layout (windows stack vertically) |
| `Mod+w` | Tabbed layout (windows as tabs) |
| `Mod+e` | Toggle split layout (horizontal/vertical) |
| `Mod+v` | Next container splits vertically |
| `Mod+b` | Next container splits horizontally |

---

## Workspaces

### Switch to Workspace
| Keybinding | Workspace |
|------------|-----------|
| `Mod+1` | Workspace 1 |
| `Mod+2` | Workspace 2 |
| `Mod+3` | Workspace 3 |
| `Mod+4` | Workspace 4 |
| `Mod+5` | Workspace 5 |
| `Mod+6` | Workspace 6 |
| `Mod+7` | Workspace 7 |
| `Mod+8` | Workspace 8 |
| `Mod+9` | Workspace 9 |
| `Mod+0` | Workspace 10 |

### Move Window to Workspace
| Keybinding | Action |
|------------|--------|
| `Mod+Shift+1` | Move window to workspace 1 |
| `Mod+Shift+2` | Move window to workspace 2 |
| `Mod+Shift+3` | Move window to workspace 3 |
| `Mod+Shift+4` | Move window to workspace 4 |
| `Mod+Shift+5` | Move window to workspace 5 |
| `Mod+Shift+6` | Move window to workspace 6 |
| `Mod+Shift+7` | Move window to workspace 7 |
| `Mod+Shift+8` | Move window to workspace 8 |
| `Mod+Shift+9` | Move window to workspace 9 |
| `Mod+Shift+0` | Move window to workspace 10 |

---

## Multi-Monitor Support

### Monitor Focus
| Keybinding | Action |
|------------|--------|
| `Mod+m` | Focus left monitor |
| `Mod+Shift+m` | Focus right monitor |

### Workspace Movement Between Monitors
| Keybinding | Action |
|------------|--------|
| `Mod+Ctrl+h` | Move current workspace to left monitor |
| `Mod+Ctrl+l` | Move current workspace to right monitor |

### Display Configuration
| Keybinding | Action |
|------------|--------|
| `Mod+Shift+d` | Open arandr (graphical display manager) |

**Manual Monitor Setup:**
```bash
# List connected monitors
xrandr

# Set dual monitor (primary on left, secondary on right)
xrandr --output HDMI-1 --auto --primary --output DP-1 --auto --right-of HDMI-1

# Single monitor (disable secondary)
xrandr --output HDMI-1 --auto --output DP-1 --off
```

---

## Application Launchers

| Keybinding | Action |
|------------|--------|
| `Mod+Return` | Open terminal (Alacritty) |
| `Mod+d` | Open application launcher (rofi) |
| `Mod+Shift+d` | Open window switcher (rofi) |

---

## Resizing Windows

### Enter Resize Mode
Press `Mod+r` to enter resize mode, then use:

| Key | Action |
|-----|--------|
| `h` | Shrink width (move right edge left) |
| `j` | Grow height (move bottom edge down) |
| `k` | Shrink height (move bottom edge up) |
| `l` | Grow width (move right edge right) |
| `Shift+h` | Shrink width (move left edge right) |
| `Shift+j` | Grow height (move top edge down) |
| `Shift+k` | Shrink height (move top edge up) |
| `Shift+l` | Grow width (move left edge left) |
| `Return` or `Escape` | Exit resize mode |

---

## Scratchpad (Hidden Workspace)

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+minus` | Move window to scratchpad |
| `Mod+minus` | Toggle scratchpad visibility |

**Use Case**: Store frequently-used windows (music player, notes) that you can quickly show/hide.

---

## NordVPN Integration

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+v` | Toggle VPN connection (on/off) |
| `Mod+Ctrl+v` | Open VPN server selection menu |

**Manual VPN Commands:**
```bash
# Connect to VPN
nordvpn connect

# Connect to specific country
nordvpn connect Italy
nordvpn connect United_States

# Disconnect
nordvpn disconnect

# Check status
nordvpn status

# List countries
nordvpn countries
```

**Status Bar**: Shows VPN status and connected server in top bar.

---

## Audio Controls

### Keyboard Controls
| Keybinding | Action |
|------------|--------|
| `XF86AudioRaiseVolume` | Increase volume by 5% |
| `XF86AudioLowerVolume` | Decrease volume by 5% |
| `XF86AudioMute` | Toggle mute |
| `Mod+Plus` | Increase volume by 5% (alternative) |
| `Mod+Minus` | Decrease volume by 5% (alternative) |

**Note**: `Mod+m` is used for monitor focus. Use media keys or click the status bar volume icon to mute.

### Status Bar Controls (Top Bar)
| Mouse Action | Effect |
|--------------|--------|
| `Left Click on Volume` | Toggle mute/unmute |
| `Scroll Up on Volume` | Increase volume by 5% |
| `Scroll Down on Volume` | Decrease volume by 5% |

**Volume Display**: Shows 🔊 icon with current percentage (e.g., "🔊 80%")
**Muted Display**: Shows 🔇 icon when muted

**Manual Volume Commands:**
```bash
# Set specific volume
vol-50    # Set to 50%
vol-80    # Set to 80%
vol-100   # Set to 100%

# Adjust volume
vol-up    # Increase by 5%
vol-down  # Decrease by 5%
vol-mute  # Toggle mute

# Check current volume
vol       # Display current volume percentage
```

---

## Printer Management

### Keyboard Controls
| Keybinding | Action |
|------------|--------|
| `Mod+p` | Open printer management menu |
| `Mod+Shift+p` | Open printer configuration GUI |
| `Mod+Ctrl+p` | Open CUPS web interface |

### Printer Menu Options
When you press `Mod+p`, a rofi menu appears with these options:
- **Configure Printers** - Open system-config-printer GUI
- **CUPS Web Interface** - Open http://localhost:631 in browser
- **View Print Queue** - Show active print jobs
- **Cancel All Jobs** - Cancel all pending print jobs
- **Print Test Page** - Send test page to default printer
- **Restart CUPS** - Restart the printing service
- **Printer Status** - Show detailed printer information
- **View CUPS Logs** - Display recent CUPS error logs

### Zsh Printer Aliases
| Command | Action |
|---------|--------|
| `printers` | List all printers and show default |
| `pq` | View print queue |
| `pqall` | View all jobs (completed + pending) |
| `pcancel` | Cancel all print jobs |
| `pstatus` | Show detailed printer status |
| `pconf` | Open printer configuration GUI |
| `pcups` | Open CUPS web interface |
| `ptest` | Print a test page |
| `plogs` | View live CUPS error logs |
| `prestart` | Restart CUPS service |
| `pdefault` | Show default printer |
| `pdrivers` | List available printer drivers |
| `pdevices` | List available printer devices |
| `print <file>` | Print a file |

### Quick Printing from Terminal
```bash
# Print a file to default printer
print document.pdf

# Print to specific printer
lp -d PrinterName document.pdf

# Print multiple copies
lp -n 5 document.pdf

# Print with options
lp -o media=a4 -o sides=two-sided-long-edge document.pdf

# Print page range
lp -P 1-10,15,20 document.pdf
```

### First-Time Setup
1. **Install CUPS** (if not already installed):
   ```bash
   sudo apt install cups cups-client system-config-printer
   ```

2. **Start CUPS service**:
   ```bash
   sudo systemctl enable cups
   sudo systemctl start cups
   ```

3. **Add yourself to lp group** (for permissions):
   ```bash
   sudo usermod -aG lp $USER
   # Log out and back in for changes to take effect
   ```

4. **Add a printer**:
   - Press `Mod+Shift+p` to open printer configuration
   - Click "Add" to add a new printer
   - Select your printer from the list
   - Follow the setup wizard

**For detailed printer management guide, see [PRINTER_MANAGEMENT.md](PRINTER_MANAGEMENT.md)**

---

## System Control

| Keybinding | Action |
|------------|--------|
| `Mod+Shift+c` | Reload i3 configuration |
| `Mod+Shift+r` | Restart i3 in place |
| `Mod+Shift+e` | Exit i3 (logout) |

---

## Configuration

### Main Config File
- **Location**: `~/.config/i3/config`
- **Edit**: `nvim ~/.config/i3/config`
- **Reload**: `Mod+Shift+c` or `i3-msg reload`

### Status Bar Config
- **Location**: `~/.config/i3status/config`
- **Custom Wrapper**: `~/.config/i3/scripts/i3status-wrapper.sh` (adds VPN/GPU info)

### Keyboard Layout
- **Set Italian Layout**: `setxkbmap -layout it`
- **Set US Layout**: `setxkbmap -layout us`
- **Auto-set on Startup**: Configured in `~/.config/i3/config`

---

## Advanced Usage

### Splitting Containers
```
1. Open terminal (Mod+Return)
2. Split vertically (Mod+v)
3. Open another terminal (Mod+Return)
4. Split horizontally (Mod+b)
5. Open third terminal (Mod+Return)
Result: 3 terminals in custom layout
```

### Stacking Windows
```
1. Focus workspace with multiple windows
2. Press Mod+s (stacking mode)
3. Windows stack vertically with tabs at top
4. Navigate with Mod+j/k
```

### Tabbed Layout
```
1. Focus workspace with multiple windows
2. Press Mod+w (tabbed mode)
3. Windows appear as tabs
4. Switch with Mod+h/l
```

### Floating Windows
```
# Make window float
Mod+Shift+Space

# Move floating window
Hold Mod + drag with mouse
or
Mod+Shift+h/j/k/l

# Resize floating window
Hold Mod + right-click drag
or
Enter resize mode (Mod+r)
```

---

## Troubleshooting

### Windows Key Not Working
```bash
# Test if Super key is detected
xev | grep -i super

# Re-bind Mod key in config
vim ~/.config/i3/config
# Find: set $mod Mod4
# Mod4 = Windows key
# Mod1 = Alt key
```

### Reload Not Working
```bash
# Force reload from terminal
i3-msg reload

# Restart i3
i3-msg restart

# Check config for errors
i3 -C -c ~/.config/i3/config
```

### Monitor Not Detected
```bash
# Detect monitors
xrandr --query

# Run auto-setup script
~/.config/i3/scripts/monitor-setup.sh

# Open graphical tool
arandr
```

---

## Tips & Best Practices

1. **Workspace Organization**:
   - Workspace 1: Terminals
   - Workspace 2: Browser
   - Workspace 3: Code editor
   - Workspace 4-10: Project-specific

2. **Quick Window Management**:
   - Use `Mod+1` through `Mod+0` to jump between workspaces
   - Use scratchpad for frequently-accessed tools
   - Keep fewer than 4 windows per workspace for clarity

3. **Multi-Monitor Workflow**:
   - Keep communication apps (Slack, email) on secondary monitor
   - Use `Mod+Ctrl+h/l` to move entire workspaces between monitors
   - Use `Mod+m/Shift+m` to jump between monitors quickly

4. **Keyboard-Only Workflow**:
   - Use `Mod+d` for app launcher instead of clicking
   - Use `Mod+h/j/k/l` for navigation instead of mouse
   - Use resize mode (`Mod+r`) for precise window sizing

---

## Quick Reference Card

```
ESSENTIAL SHORTCUTS:
Mod+Return          → Terminal
Mod+d               → App launcher
Mod+Shift+q         → Kill window
Mod+h/j/k/l         → Navigate windows
Mod+1-9             → Switch workspace
Mod+f               → Fullscreen
Mod+r               → Resize mode
Mod+Shift+c         → Reload config

LAYOUTS:
Mod+s               → Stacking
Mod+w               → Tabbed
Mod+e               → Toggle split
Mod+v/b             → Vertical/Horizontal split

MULTI-MONITOR:
Mod+m               → Focus left monitor
Mod+Shift+m         → Focus right monitor
Mod+Ctrl+h/l        → Move workspace to monitor
Mod+Shift+d         → Display settings (arandr)

PRINTER:
Mod+p               → Printer menu
Mod+Shift+p         → Printer config GUI
Mod+Ctrl+p          → CUPS web interface

VPN:
Mod+Shift+v         → Toggle VPN
Mod+Ctrl+v          → VPN server menu
```

---

**Note**: This configuration uses the Italian keyboard layout by default. To change, edit `~/.config/i3/config` and modify the `setxkbmap` line.
