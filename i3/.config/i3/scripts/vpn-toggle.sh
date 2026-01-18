#!/bin/bash

# Toggle NordVPN connection

vpn_status=$(nordvpn status | grep Status | awk '{print $2}')

if [ "$vpn_status" = "Connected" ]; then
    nordvpn disconnect
    notify-send "NordVPN" "Disconnected" -i network-vpn-disconnected
else
    nordvpn connect
    notify-send "NordVPN" "Connecting..." -i network-vpn
fi
