# NordVPN & GPU Monitoring Setup

## ✅ What Was Configured

### 1. i3 Status Bar Enhanced
The status bar now shows:
- **GPU Utilization**: GPU usage %, temperature, memory usage
- **NordVPN Status**: Connected/Disconnected with server info
- All existing i3status information (CPU, RAM, disk, network, time, etc.)

### 2. NordVPN Keybindings
| Keys | Action |
|------|--------|
| `⊞ + Shift + v` | **Quick toggle VPN on/off** |
| `⊞ + Ctrl + v` | **VPN menu** (select country) |

Available countries in menu:
- Italy 🇮🇹
- United States 🇺🇸
- United Kingdom 🇬🇧
- Germany 🇩🇪

### 3. Status Bar Information
Located at the **top of the screen**, shows:
```
GPU: 45% 38°C MEM: 6% | VPN: ✓ Italy123 | CPU | RAM | Disk | ...
```

---

## 🔧 Setup NordVPN (First Time)

NordVPN is already installed but needs permissions. Run:

```bash
cd ~/.dotfiles
bash scripts/setup-nordvpn.sh
```

This will:
1. Create the `nordvpn` group
2. Add your user to the group
3. Require you to **log out and log back in**

---

## 🚀 Using NordVPN

### After Logging Back In

**1. Login to NordVPN:**
```bash
nordvpn login
```
This will open a browser to authenticate.

**2. Quick Connect:**
```bash
nordvpn connect
```

**3. Connect to Specific Country:**
```bash
nordvpn connect Italy
nordvpn connect United_States
nordvpn connect Germany
```

**4. Disconnect:**
```bash
nordvpn disconnect
```

**5. Check Status:**
```bash
nordvpn status
```

### Using i3 Keybindings

Once NordVPN is set up:

1. **Quick Toggle**: Press `⊞ + Shift + v`
   - If disconnected → Connects to fastest server
   - If connected → Disconnects

2. **Country Menu**: Press `⊞ + Ctrl + v`
   - Opens rofi menu
   - Select country or action
   - Shows status

---

## 📊 GPU Monitoring

GPU information automatically appears in the status bar:
- **GPU %**: Current GPU utilization
- **Temp**: GPU temperature in °C
- **MEM %**: GPU memory usage

Works with NVIDIA GPUs using `nvidia-smi`.

---

## 🎨 Status Bar Colors

- **VPN Connected**: Green text with ✓
- **VPN Disconnected**: Red text with ✗
- **GPU**: Default status bar color

---

## 🔍 Manual Commands

### NordVPN CLI
```bash
# Settings
nordvpn settings              # Show all settings
nordvpn set killswitch on     # Enable kill switch
nordvpn set cybersec on       # Enable CyberSec (ad blocking)
nordvpn set autoconnect on    # Auto-connect on startup

# Connection
nordvpn connect               # Connect to fastest server
nordvpn connect Italy         # Connect to Italy
nordvpn connect P2P           # Connect to P2P server
nordvpn quickconnect          # Quick connect alias

# Information
nordvpn status                # Connection status
nordvpn account               # Account information
nordvpn countries             # List available countries
nordvpn cities Italy          # List cities in Italy
```

### GPU Monitoring
```bash
# Full GPU info
nvidia-smi

# Watch GPU in real-time
watch -n 1 nvidia-smi

# Simple stats
nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv
```

---

## 📁 Created Files

```
~/.dotfiles/i3/.config/i3/scripts/
├── i3status-wrapper.sh      # Status bar with VPN & GPU
├── vpn-toggle.sh             # Quick VPN toggle
└── vpn-menu.sh               # VPN country menu

~/.dotfiles/scripts/
└── setup-nordvpn.sh          # NordVPN permissions setup
```

---

## 🐛 Troubleshooting

### VPN Not Showing in Status Bar
1. Check NordVPN is running: `nordvpn status`
2. Restart i3: `⊞ + Shift + r`
3. Check logs: `journalctl -xe | grep nordvpn`

### GPU Info Not Showing
1. Verify nvidia-smi works: `nvidia-smi`
2. Check NVIDIA drivers: `nvidia-smi --query-gpu=driver_version --format=csv`
3. Restart i3: `⊞ + Shift + r`

### Keybindings Not Working
1. Reload i3 config: `⊞ + Shift + c`
2. Check scripts are executable: `ls -la ~/.config/i3/scripts/`
3. Restart i3: `⊞ + Shift + r`

---

## 📝 Next Steps

1. **Run the setup script:**
   ```bash
   cd ~/.dotfiles
   bash scripts/setup-nordvpn.sh
   ```

2. **Log out and log back in**

3. **Login to NordVPN:**
   ```bash
   nordvpn login
   ```

4. **Test VPN toggle:**
   - Press `⊞ + Shift + v`
   - Check status bar for VPN status

5. **Enjoy!**
   - GPU and VPN info now in your status bar
   - Quick VPN control with keyboard shortcuts
