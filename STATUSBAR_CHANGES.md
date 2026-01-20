# i3 Status Bar Changes

## ✅ Changes Applied

### 1. **Removed from Status Bar**
- ❌ Battery information (removed)
- ❌ WiFi information (removed)

### 2. **Added Interactive Volume Control**
- ✅ Volume now displays with emoji: 🔊 80% (or 🔇 when muted)
- ✅ **Click volume to mute/unmute**
- ✅ **Scroll up on volume to increase by 5%**
- ✅ **Scroll down on volume to decrease by 5%**

### 3. **Improved Update Frequency**
- Changed update interval from 5 seconds to 1 second for responsive volume display

### 4. **Current Status Bar Layout**
```
[GPU: 45% 65°C MEM: 30%] | [VPN: ✓ it123] | [CPU: 25%] | [RAM: 8.2G / 16G] | [Disk: 450G] | [Eth: 192.168.1.10 (1000Mbit/s)] | [🔊 80%] | [2026-01-19 15:30:45]
```

---

## 🎮 How to Use Volume Control

### Mouse Controls (on Status Bar)
- **Left Click** on volume → Toggle mute/unmute
- **Scroll Up** on volume → Increase volume by 5%
- **Scroll Down** on volume → Decrease volume by 5%

### Keyboard Controls
- `Mod+Plus` → Increase volume by 5%
- `Mod+Minus` → Decrease volume by 5%
- `Mod+m` → Toggle mute
- `XF86AudioRaiseVolume` → Increase volume (media key)
- `XF86AudioLowerVolume` → Decrease volume (media key)
- `XF86AudioMute` → Toggle mute (media key)

### Terminal Commands
```bash
vol           # Show current volume
vol-50        # Set to 50%
vol-80        # Set to 80%
vol-100       # Set to 100%
vol-up        # Increase by 5%
vol-down      # Decrease by 5%
vol-mute      # Toggle mute
```

---

## 📁 Files Modified

1. **`i3/.config/i3status/config`**
   - Removed battery and wireless from order
   - Changed interval to 1 second
   - Enabled i3bar output format
   - Updated volume format with emoji icons

2. **`i3/.config/i3/config`**
   - Changed status_command to use new wrapper: `i3bar-wrapper.sh`
   - Added audio control keybindings

3. **`i3/.config/i3/scripts/i3bar-wrapper.sh`** (NEW)
   - Enhanced wrapper with click event handling
   - Handles volume clicks (mute, scroll)
   - Maintains GPU and VPN info display

4. **`zsh/.zsh/aliases.zsh`**
   - Added volume control aliases

5. **Documentation Updates**
   - `COMMANDS_I3.md` - Added status bar controls section
   - `COMMANDS_ZSH.md` - Added audio controls section
   - `README.md` - Updated i3 features list

---

## 🔧 Technical Details

### Click Event Handling
The new wrapper script (`i3bar-wrapper.sh`) implements JSON protocol for i3bar:
- Sends `{"version":1,"click_events":true}` header
- Listens for click events from i3bar
- Parses button numbers: 1=left click, 4=scroll up, 5=scroll down
- Executes `amixer` commands to control volume

### JSON Output Format
i3status now outputs JSON format which allows:
- Click event support
- Custom blocks (GPU, VPN)
- Better formatting and colors
- Real-time updates

---

## 🧪 Testing

After changes, the status bar should:
1. ✅ Show volume with 🔊 or 🔇 emoji
2. ✅ Update volume display every 1 second
3. ✅ Respond to mouse clicks on volume
4. ✅ Still show GPU and VPN information
5. ✅ NOT show battery or WiFi info

---

## 🔄 Rollback (if needed)

If you want to restore the old status bar:

```bash
cd ~/.dotfiles/i3/.config/i3

# Backup current config
cp config config.new

# Restore old status command in config
# Change: status_command ~/.config/i3/scripts/i3bar-wrapper.sh
# Back to: status_command ~/.config/i3/scripts/i3status-wrapper.sh

# Restore old i3status config
cd ~/.config/i3status
# Change interval back to 5
# Remove output_format line
# Add back battery and wireless to order

# Restart i3
i3-msg restart
```

---

## 📚 References

- [i3 User's Guide - Status Command](https://i3wm.org/docs/userguide.html#_configuring_i3bar)
- [i3bar Protocol](https://i3wm.org/docs/i3bar-protocol.html)
- [i3status Manual](https://i3wm.org/i3status/manpage.html)

---

## 💡 Future Enhancements

Possible future additions:
- Click on CPU/RAM to open system monitor
- Click on VPN to toggle connection
- Click on time to open calendar
- Add brightness control (for laptops)
- Add network traffic indicator
