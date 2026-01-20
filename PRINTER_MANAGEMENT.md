# Printer Management in i3 Desktop Environment

Complete guide for managing printers on Linux with i3 window manager using CUPS (Common Unix Printing System).

---

## Table of Contents
1. [Installation](#installation)
2. [GUI Management](#gui-management)
3. [Web Interface](#web-interface)
4. [Command Line](#command-line)
5. [Common Tasks](#common-tasks)
6. [Troubleshooting](#troubleshooting)
7. [i3 Integration](#i3-integration)

---

## Installation

### Install CUPS and Printer Tools

```bash
# Install CUPS printing system
sudo apt install cups cups-client cups-bsd

# Install GUI printer configuration tool
sudo apt install system-config-printer

# Install printer drivers (choose what you need)
sudo apt install printer-driver-all        # All available drivers
sudo apt install printer-driver-hpijs      # HP printers
sudo apt install printer-driver-gutenprint # Canon, Epson, etc.
sudo apt install printer-driver-brlaser    # Brother laser printers
sudo apt install printer-driver-escpr      # Epson ESC/P-R printers

# Enable and start CUPS service
sudo systemctl enable cups
sudo systemctl start cups

# Add your user to the lp group (for permissions)
sudo usermod -aG lp $USER
```

**Note**: Log out and back in after adding yourself to the `lp` group.

---

## GUI Management

### System Config Printer (Recommended for i3)

Launch from terminal or dmenu:
```bash
system-config-printer
```

**i3 Keybinding** (add to `~/.config/i3/config`):
```
bindsym $mod+Shift+p exec system-config-printer
```

#### Permission Issues in i3

If you encounter PolicyKit permission errors, you have two options:

**Option 1: Run with sudo**
```bash
sudo system-config-printer
```

**Option 2: Add yourself to lp and lpadmin groups**
```bash
sudo usermod -aG lp,lpadmin $USER
```

### Features
- Add/remove printers
- Set default printer
- Configure printer settings
- View print queue
- Test page printing
- Manage print jobs

---

## Web Interface

CUPS provides a powerful web interface accessible from any browser.

### Access the Web Interface

```bash
# Open CUPS web interface
xdg-open http://localhost:631
```

Or in your browser, navigate to: **http://localhost:631**

### Web Interface Sections

1. **Home** - Overview and documentation
2. **Administration** - Add/manage printers (requires login)
3. **Printers** - View all configured printers
4. **Jobs** - View and manage print jobs
5. **Help** - CUPS documentation

### Administration Tasks (requires authentication)

When performing admin tasks, use your system credentials:
- **Username**: Your Linux username
- **Password**: Your sudo password

**Common Tasks**:
- Add Printer
- Manage Printers
- Set Default Printer
- Edit Configuration File
- View Error Log

---

## Command Line

Complete reference for managing printers from the terminal.

### Printer Discovery

```bash
# List all available printers on the network
lpinfo --include-schemes dnssd -v

# List all printer drivers
lpinfo -m

# List local devices
lpinfo -v
```

### Printer Management

```bash
# List all configured printers
lpstat -p -d

# List printers with verbose info
lpstat -l -p

# Show default printer
lpstat -d

# Add a printer (driverless - recommended for modern printers)
lpadmin -p PrinterName -E -v ipp://192.168.1.100/ipp/print -m everywhere

# Add a printer with specific driver
lpadmin -p PrinterName -E -v usb://HP/LaserJet -m drv:///hp/hpcups.drv/hp-laserjet_1320.ppd

# Set default printer
lpadmin -d PrinterName

# Remove a printer
lpadmin -x PrinterName

# Enable a printer
cupsenable PrinterName

# Disable a printer
cupsdisable PrinterName

# Set printer location
lpadmin -p PrinterName -L "Office Room 101"

# Set printer description
lpadmin -p PrinterName -D "HP LaserJet Office Printer"

# Share printer on network
lpadmin -p PrinterName -o printer-is-shared=true

# Accept jobs for printer
cupsaccept PrinterName

# Reject jobs for printer
cupsreject PrinterName
```

### Print Queue Management

```bash
# List all print jobs
lpstat -o

# List jobs for specific printer
lpstat -o PrinterName

# View job details
lpstat -l -o

# Cancel all jobs
cancel -a

# Cancel specific job
cancel JobID

# Cancel all jobs for specific printer
cancel -a PrinterName

# Cancel specific job for specific printer
cancel JobID -h localhost
```

### Printing Files

```bash
# Print a file
lp filename.pdf

# Print to specific printer
lp -d PrinterName filename.pdf

# Print multiple copies
lp -n 5 filename.pdf

# Print with options
lp -d PrinterName -o media=a4 -o sides=two-sided-long-edge filename.pdf

# Print page range
lp -P 1-10,15,20-25 filename.pdf

# Print in landscape
lp -o landscape filename.pdf

# Print in color or grayscale
lp -o ColorModel=Gray filename.pdf
lp -o ColorModel=RGB filename.pdf
```

### Printer Status

```bash
# Check printer status
lpstat -p PrinterName

# Check if printer is accepting jobs
lpstat -a PrinterName

# View printer options
lpoptions -p PrinterName -l

# Get detailed printer info
lpstat -l -p PrinterName

# Check CUPS service status
systemctl status cups

# View CUPS error log
sudo tail -f /var/log/cups/error_log
```

---

## Common Tasks

### Add a Network Printer (Driverless - Modern Printers)

Most printers from 2010+ support driverless printing via IPP Everywhere or AirPrint.

```bash
# 1. Discover the printer
lpinfo --include-schemes dnssd -v

# 2. Add the printer (use the URI from step 1)
lpadmin -p MyPrinter -E -v ipp://192.168.1.100/ipp/print -m everywhere

# 3. Set as default (optional)
lpadmin -d MyPrinter

# 4. Test print
lp -d MyPrinter /etc/hosts
```

### Add a USB Printer

```bash
# 1. Connect printer via USB and discover it
lpinfo -v | grep usb

# 2. Add the printer
lpadmin -p USBPrinter -E -v usb://HP/LaserJet -m everywhere

# 3. Set as default
lpadmin -d USBPrinter
```

### Add a Printer with Specific Driver

```bash
# 1. List available drivers
lpinfo -m | grep -i "HP LaserJet"

# 2. Add printer with specific PPD
lpadmin -p HPLaser -E -v usb://HP/LaserJet -m drv:///hp/hpcups.drv/hp-laserjet_1320.ppd
```

### Set Printer Options

```bash
# View available options
lpoptions -p PrinterName -l

# Set default options for printer
lpoptions -p PrinterName -o media=a4 -o sides=two-sided-long-edge

# Set options for current user only
lpoptions -p PrinterName -o ColorModel=Gray
```

### Test Print

```bash
# Print a test page
lp -d PrinterName /usr/share/cups/data/testprint

# Or use GUI test page
system-config-printer
# Right-click printer → Print Test Page
```

---

## Troubleshooting

### CUPS Service Issues

```bash
# Check CUPS status
systemctl status cups

# Restart CUPS
sudo systemctl restart cups

# Enable CUPS to start on boot
sudo systemctl enable cups

# Check CUPS logs
sudo tail -f /var/log/cups/error_log
sudo tail -f /var/log/cups/access_log
```

### Printer Not Found

```bash
# Make sure CUPS is running
sudo systemctl start cups

# Check if printer is connected (USB)
lsusb

# Scan network for printers
lpinfo --include-schemes dnssd -v

# Check firewall (allow CUPS)
sudo ufw allow 631/tcp
```

### Permission Issues

```bash
# Add user to lp and lpadmin groups
sudo usermod -aG lp,lpadmin $USER

# Log out and back in for changes to take effect

# Verify group membership
groups $USER
```

### Print Job Stuck

```bash
# List all jobs
lpstat -o

# Cancel all jobs
cancel -a

# Restart printer
cupsdisable PrinterName
cupsenable PrinterName

# Restart CUPS
sudo systemctl restart cups
```

### Printer Shows as Paused

```bash
# Resume printer
cupsenable PrinterName

# Accept jobs
cupsaccept PrinterName

# Check status
lpstat -p PrinterName
```

### Driver Issues

```bash
# List installed drivers
lpinfo -m

# Install additional drivers
sudo apt install printer-driver-all

# For HP printers, install HPLIP
sudo apt install hplip hplip-gui
hp-setup  # Interactive setup for HP printers
```

### Reset Printer Configuration

```bash
# Remove printer
lpadmin -x PrinterName

# Stop CUPS
sudo systemctl stop cups

# Remove configuration files
sudo rm /etc/cups/printers.conf
sudo rm /etc/cups/ppd/*

# Restart CUPS
sudo systemctl start cups

# Re-add printer
lpadmin -p PrinterName -E -v ipp://... -m everywhere
```

---

## i3 Integration

### i3 Configuration

Add to `~/.config/i3/config`:

```bash
# Printer management
bindsym $mod+Shift+p exec system-config-printer

# Open CUPS web interface
bindsym $mod+Ctrl+p exec xdg-open http://localhost:631

# Quick print test page (set your default printer name)
bindsym $mod+Alt+p exec lp /usr/share/cups/data/testprint
```

### Rofi/dmenu Integration

Create a printer menu script `~/.config/i3/scripts/printer-menu.sh`:

```bash
#!/bin/bash
# Printer management menu for rofi/dmenu

OPTIONS="Configure Printers\nCUPS Web Interface\nView Print Queue\nCancel All Jobs\nPrint Test Page\nRestart CUPS"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Printer Management:")

case "$CHOICE" in
    "Configure Printers")
        system-config-printer &
        ;;
    "CUPS Web Interface")
        xdg-open http://localhost:631 &
        ;;
    "View Print Queue")
        kitty -e bash -c "lpstat -o; read -p 'Press enter to close...'" &
        ;;
    "Cancel All Jobs")
        cancel -a
        notify-send "Printer" "All print jobs cancelled"
        ;;
    "Print Test Page")
        DEFAULT_PRINTER=$(lpstat -d | awk '{print $4}')
        lp -d "$DEFAULT_PRINTER" /usr/share/cups/data/testprint
        notify-send "Printer" "Test page sent to $DEFAULT_PRINTER"
        ;;
    "Restart CUPS")
        sudo systemctl restart cups
        notify-send "Printer" "CUPS service restarted"
        ;;
esac
```

Make it executable and add keybinding:
```bash
chmod +x ~/.config/i3/scripts/printer-menu.sh

# Add to i3 config:
# bindsym $mod+p exec ~/.config/i3/scripts/printer-menu.sh
```

### Zsh Aliases

Add to `~/.zsh/aliases.zsh`:

```bash
# Printer management aliases
alias printers='lpstat -p -d'
alias pq='lpstat -o'              # Print queue
alias pcancel='cancel -a'         # Cancel all jobs
alias pconf='system-config-printer'
alias pcups='xdg-open http://localhost:631'
alias pstatus='lpstat -l -p'
alias ptest='lp /usr/share/cups/data/testprint'
alias plogs='sudo tail -f /var/log/cups/error_log'
```

---

## Quick Reference

### Essential Commands

```bash
# List printers
lpstat -p -d

# Print file
lp filename.pdf

# View queue
lpstat -o

# Cancel job
cancel JobID

# Add printer (driverless)
lpadmin -p Name -E -v ipp://IP/ipp/print -m everywhere

# Set default
lpadmin -d Name

# Web interface
xdg-open http://localhost:631
```

### Keyboard Shortcuts (i3)

```
Mod+Shift+p         → Open printer configuration
Mod+Ctrl+p          → Open CUPS web interface
Mod+p               → Printer management menu
```

### Zsh Aliases

```
printers            → List all printers
pq                  → View print queue
pcancel             → Cancel all jobs
pconf               → Open printer config GUI
pcups               → Open CUPS web interface
```

---

## Additional Resources

- **CUPS Documentation**: https://www.cups.org/doc/
- **Arch Wiki CUPS Guide**: https://wiki.archlinux.org/title/CUPS
- **Ubuntu CUPS Server**: https://documentation.ubuntu.com/server/how-to/networking/cups-print-server/
- **Red Hat CUPS Guide**: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/configuring_and_using_a_cups_printing_server/
- **Command Reference**: https://www.cups.org/doc/admin.html

---

**Note**: Modern printers (2010+) generally support driverless printing via IPP Everywhere or AirPrint. Always try the `-m everywhere` option first before installing specific drivers. This provides the best compatibility and eliminates driver maintenance issues.
