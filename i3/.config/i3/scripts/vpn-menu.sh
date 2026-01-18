#!/bin/bash

# NordVPN menu using rofi

OPTIONS="Connect\nDisconnect\nConnect Italy\nConnect US\nConnect UK\nConnect Germany\nStatus"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "NordVPN" -i)

case "$CHOICE" in
    "Connect")
        nordvpn connect && notify-send "NordVPN" "Connecting to fastest server..."
        ;;
    "Disconnect")
        nordvpn disconnect && notify-send "NordVPN" "Disconnected"
        ;;
    "Connect Italy")
        nordvpn connect Italy && notify-send "NordVPN" "Connecting to Italy..."
        ;;
    "Connect US")
        nordvpn connect United_States && notify-send "NordVPN" "Connecting to US..."
        ;;
    "Connect UK")
        nordvpn connect United_Kingdom && notify-send "NordVPN" "Connecting to UK..."
        ;;
    "Connect Germany")
        nordvpn connect Germany && notify-send "NordVPN" "Connecting to Germany..."
        ;;
    "Status")
        nordvpn status | rofi -dmenu -p "NordVPN Status"
        ;;
esac
