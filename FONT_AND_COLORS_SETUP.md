# Terminal & Vim Font and Color Setup

## ✅ What Was Fixed

### 1. **Font Changed to Clear Retro Style**
- **Old**: FiraCode Nerd Font 11pt (overlapping characters)
- **New**: DejaVu Sans Mono 13pt (clear, retro, no overlapping)

**Why DejaVu Sans Mono?**
- Classic programming font (1990s style)
- Crystal clear character spacing
- No ligatures (every character distinct)
- Excellent readability
- Always pre-installed on Ubuntu

### 2. **High Contrast Retro Color Scheme**
- **Background**: Deep black (#0a0e14)
- **Foreground**: Light gray (#b3b1ad) - excellent contrast
- **Colors**: Vibrant retro palette
  - Bright red for errors
  - Retro green for success
  - Amber/orange for warnings
  - Electric blue for info
  - Bright cursor (cyan)

### 3. **Font Improvements**
- **Size**: Increased from 11pt to 13pt
- **Spacing**: Added font offset to prevent overlapping
- **Style**: No ligatures for clearest readability
- **Applied to**: Alacritty terminal AND Neovim

---

## 🎨 Color Palette Preview

```
Background:  ███████  Deep black
Foreground:  ███████  Light gray
Red:         ███████  Bright red (errors)
Green:       ███████  Retro green (success)
Yellow:      ███████  Amber (warnings)
Blue:        ███████  Electric blue (info)
Cyan:        ███████  Mint green (cursor/selection)
```

---

## 🖥️ Terminal Font Details

**Alacritty Configuration:**
```toml
Font: DejaVu Sans Mono
Size: 13pt
Style: Book (regular)
Bold: Available
Italic: Oblique style
Spacing: Optimized to prevent overlapping
```

**Neovim Configuration:**
- Uses terminal font automatically (DejaVu Sans Mono 13pt)
- GUI font set to: `DejaVu Sans Mono:h13`
- High contrast color scheme
- No italics for clearer code

---

## 📝 Alternative Fonts (If You Want to Try)

If you want to test other retro fonts, edit `~/.config/alacritty/alacritty.toml`:

### Option 1: Ubuntu Mono (Modern Retro)
```toml
normal = { family = "Ubuntu Mono", style = "Regular" }
size = 14.0
```

### Option 2: Courier New (Classic)
```toml
normal = { family = "Courier New", style = "Regular" }
size = 13.0
```

### Option 3: Liberation Mono (IBM Clone)
```toml
normal = { family = "Liberation Mono", style = "Regular" }
size = 13.0
```

### Option 4: Terminus (Ultra Retro - Bitmap)
First install:
```bash
sudo apt install xfonts-terminus
```

Then use:
```toml
normal = { family = "Terminus", style = "Regular" }
size = 14.0
```

---

## 🔧 How to Change Font Size

Edit: `~/.config/alacritty/alacritty.toml`

Find the line:
```toml
size = 13.0
```

Change to your preference:
- **Smaller**: 11.0 or 12.0
- **Larger**: 14.0 or 15.0

Then restart Alacritty (just close and reopen).

---

## 🎨 Alternative Color Schemes

### Classic Green Terminal (CRT Monitor)
Edit `~/.config/alacritty/alacritty.toml`, change:
```toml
[colors.primary]
background = "#000000"  # Pure black
foreground = "#00FF00"  # Bright green
```

### Amber Terminal (Old Monitors)
```toml
[colors.primary]
background = "#000000"
foreground = "#FFB000"  # Amber/orange
```

### High Contrast White on Black
```toml
[colors.primary]
background = "#000000"
foreground = "#FFFFFF"
```

---

## ✨ Testing the Changes

**1. Test in Alacritty:**
```bash
# Open new terminal (should see new font immediately)
alacritty

# Test colors
echo -e "\033[31mRed\033[0m \033[32mGreen\033[0m \033[33mYellow\033[0m"
```

**2. Test in Neovim:**
```bash
nvim
# Should see:
# - Clear font (no overlapping)
# - High contrast colors
# - Dark background
```

**3. Test text clarity:**
```bash
# Create test file
cat > test.txt << 'EOF'
iiii llll 1111
0O0O 8B8B
The quick brown fox jumps over the lazy dog
ABCDEFGHIJKLMNOPQRSTUVWXYZ
abcdefghijklmnopqrstuvwxyz
0123456789 !@#$%^&*()
EOF

# View in vim
nvim test.txt
```

All characters should be perfectly clear and distinct!

---

## 🐛 Troubleshooting

### Font Still Overlapping?
1. Increase font size:
   ```bash
   # In ~/.config/alacritty/alacritty.toml
   size = 14.0  # or even 15.0
   ```

2. Add more spacing:
   ```toml
   offset = { x = 0, y = 2 }  # Increase y value
   ```

### Colors Too Dim?
Edit the foreground color to be brighter:
```toml
foreground = "#FFFFFF"  # Pure white
```

### Want Original FiraCode Back?
```toml
normal = { family = "FiraCode Nerd Font", style = "Regular" }
size = 12.0
```

---

## 📁 Modified Files

```
~/.dotfiles/alacritty/.config/alacritty/alacritty.toml
  - Font: DejaVu Sans Mono 13pt
  - Colors: High contrast retro palette
  - Spacing: Fixed overlapping

~/.dotfiles/nvim/.config/nvim/lua/config/options.lua
  - GUI font: DejaVu Sans Mono 13pt

~/.dotfiles/nvim/.config/nvim/lua/config/plugins/colorscheme.lua
  - High contrast theme
  - Disabled italics for clarity
```

---

## 🚀 Quick Commands

**Reload terminal (see changes):**
```bash
# Just close and reopen Alacritty
# Or press: Ctrl+Shift+Q (close) then Mod+Enter (reopen)
```

**Test font in terminal:**
```bash
echo "Testing: abcdefg ABCDEFG 1234567890 !@#$%^&*()"
```

**Open vim to test:**
```bash
nvim ~/.zshrc
```

---

Enjoy your crystal-clear retro terminal! 🖥️✨
