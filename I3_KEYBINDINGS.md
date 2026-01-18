# i3 Window Manager - Keybindings Quick Reference

## 🔑 Super Key = Windows Key
The **Mod key** in i3 is your **Windows key** (⊞ on your keyboard)
- Also called "Super key" or "Meta key"
- Located between Ctrl and Alt on most keyboards
- Look for the Windows logo ⊞

---

## 🚀 Essential Keybindings

### Opening Applications
| Keys | Action |
|------|--------|
| `⊞ + Enter` | Open terminal (Alacritty) |
| `⊞ + d` | Application launcher (rofi) |
| `⊞ + Shift + q` | Close current window |

### Navigation (Vim-style)
| Keys | Action |
|------|--------|
| `⊞ + h` | Focus window LEFT |
| `⊞ + j` | Focus window DOWN |
| `⊞ + k` | Focus window UP |
| `⊞ + l` | Focus window RIGHT |

### Moving Windows
| Keys | Action |
|------|--------|
| `⊞ + Shift + h` | Move window LEFT |
| `⊞ + Shift + j` | Move window DOWN |
| `⊞ + Shift + k` | Move window UP |
| `⊞ + Shift + l` | Move window RIGHT |

### Workspaces
| Keys | Action |
|------|--------|
| `⊞ + 1` to `⊞ + 9` | Switch to workspace 1-9 |
| `⊞ + Shift + 1` to `9` | Move window to workspace 1-9 |

### Multi-Monitor
| Keys | Action |
|------|--------|
| `⊞ + Ctrl + h/j/k/l` | Move workspace to different monitor |
| `⊞ + m` | Focus left monitor |
| `⊞ + Shift + m` | Focus right monitor |
| `⊞ + p` | Open monitor configuration (arandr) |

### Window Layouts
| Keys | Action |
|------|--------|
| `⊞ + f` | Toggle fullscreen |
| `⊞ + v` | Split vertically (next window opens below) |
| `⊞ + b` | Split horizontally (next window opens right) |
| `⊞ + s` | Stacking layout |
| `⊞ + w` | Tabbed layout |
| `⊞ + e` | Toggle split layout |

### Resize Mode
| Keys | Action |
|------|--------|
| `⊞ + r` | Enter resize mode |
| `h/j/k/l` or arrows | Resize (while in resize mode) |
| `Enter` or `Esc` | Exit resize mode |

### System
| Keys | Action |
|------|--------|
| `⊞ + Shift + c` | Reload i3 config |
| `⊞ + Shift + r` | Restart i3 |
| `⊞ + Shift + e` | Exit i3 (logout) |
| `⊞ + Shift + x` | Lock screen |

### NordVPN
| Keys | Action |
|------|--------|
| `⊞ + Shift + v` | Toggle VPN on/off |
| `⊞ + Ctrl + v` | VPN menu (select country: Italy, US, UK, Germany) |

### Other
| Keys | Action |
|------|--------|
| `⊞ + Tab` | Window switcher (rofi) |
| `⊞ + Shift + Space` | Toggle floating window |
| `⊞ + Space` | Toggle focus (tiling/floating) |

---

## 💡 Tips

1. **First time?** Press `⊞ + Enter` to open a terminal
2. **Need apps?** Press `⊞ + d` and type the app name
3. **Lost?** Press `⊞ + 1` to go to workspace 1
4. **Multiple monitors?** Use `⊞ + Ctrl + h/l` to move workspaces between screens
5. **Want GNOME back?** Logout and select "GNOME" at login screen

---

## 🖥️ Terminal (Alacritty)

Once you open the terminal with `⊞ + Enter`:

### Copy/Paste
- `Ctrl + C` - Copy (when text is selected)
- `Ctrl + V` - Paste
- `Ctrl + Shift + C` - Copy (always works)
- `Ctrl + Shift + V` - Paste (always works)

### Tmux (Auto-starts)
- `Ctrl + a` - Tmux prefix (instead of default Ctrl+b)
- `Ctrl + a + c` - New window
- `Ctrl + a + n` - Next window
- `Ctrl + a + |` - Split horizontal
- `Ctrl + a + -` - Split vertical
- `Ctrl + a + h/j/k/l` - Navigate panes

---

## 🇮🇹 Keyboard Layout

Your Italian keyboard layout is automatically configured!

To view this file anytime:
```bash
cat ~/.dotfiles/I3_KEYBINDINGS.md
# or
nvim ~/.dotfiles/I3_KEYBINDINGS.md
```
