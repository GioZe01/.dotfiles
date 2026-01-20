#!/bin/bash
# Printer management menu for i3wm using rofi

# Check if CUPS is running
if ! systemctl is-active --quiet cups; then
    notify-send "Printer Error" "CUPS service is not running.\nStart it with: sudo systemctl start cups"
    exit 1
fi

# Menu options
OPTIONS="🖨️  Configure Printers
🌐  CUPS Web Interface
📋  View Print Queue
❌  Cancel All Jobs
📄  Print Test Page
🔄  Restart CUPS
📊  Printer Status
📝  View CUPS Logs"

# Show menu with rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Printer Management" -theme-str 'window {width: 400px;}')

case "$CHOICE" in
    "🖨️  Configure Printers")
        # Check if user is in lp group, otherwise run with sudo
        if groups | grep -q "\blp\b"; then
            system-config-printer &
        else
            notify-send "Printer" "Launching printer config (may need password)"
            pkexec system-config-printer &
        fi
        ;;

    "🌐  CUPS Web Interface")
        xdg-open http://localhost:631 &
        notify-send "Printer" "Opening CUPS web interface"
        ;;

    "📋  View Print Queue")
        # Get print queue and show in terminal
        QUEUE=$(lpstat -o 2>&1)
        if [ -z "$QUEUE" ]; then
            notify-send "Print Queue" "No active print jobs"
        else
            kitty -e bash -c "echo 'Print Queue:'; echo ''; lpstat -o; echo ''; echo 'Press Enter to close...'; read" &
        fi
        ;;

    "❌  Cancel All Jobs")
        # Confirm before cancelling
        CONFIRM=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "Cancel all print jobs?")
        if [ "$CONFIRM" = "Yes" ]; then
            cancel -a 2>&1
            notify-send "Printer" "All print jobs cancelled"
        fi
        ;;

    "📄  Print Test Page")
        # Get default printer
        DEFAULT_PRINTER=$(lpstat -d 2>/dev/null | awk '{print $4}')

        if [ -z "$DEFAULT_PRINTER" ]; then
            notify-send "Printer Error" "No default printer set.\nPlease configure a printer first."
        else
            lp -d "$DEFAULT_PRINTER" /usr/share/cups/data/testprint 2>&1
            if [ $? -eq 0 ]; then
                notify-send "Printer" "Test page sent to $DEFAULT_PRINTER"
            else
                notify-send "Printer Error" "Failed to send test page"
            fi
        fi
        ;;

    "🔄  Restart CUPS")
        notify-send "Printer" "Restarting CUPS service..."
        pkexec systemctl restart cups
        if [ $? -eq 0 ]; then
            notify-send "Printer" "CUPS service restarted successfully"
        else
            notify-send "Printer Error" "Failed to restart CUPS"
        fi
        ;;

    "📊  Printer Status")
        # Show printer status in terminal
        kitty -e bash -c "echo 'Printer Status:'; echo ''; lpstat -p -d; echo ''; lpstat -l -p; echo ''; echo 'Press Enter to close...'; read" &
        ;;

    "📝  View CUPS Logs")
        # Show recent CUPS error log
        kitty -e bash -c "echo 'CUPS Error Log (last 50 lines):'; echo ''; sudo tail -n 50 /var/log/cups/error_log; echo ''; echo 'Press Enter to close...'; read" &
        ;;
esac
