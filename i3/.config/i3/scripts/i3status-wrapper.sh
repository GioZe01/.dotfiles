#!/bin/bash

# i3status wrapper to add NordVPN and GPU utilization
# This script wraps i3status and adds custom information

i3status | while :
do
    read line

    # Get NordVPN status
    vpn_status=$(nordvpn status 2>/dev/null | grep Status | awk '{print $2}')
    if [ "$vpn_status" = "Connected" ]; then
        vpn_server=$(nordvpn status | grep "Current server" | awk '{print $3}')
        vpn_info="VPN: ✓ $vpn_server"
        vpn_color="#00FF00"
    else
        vpn_info="VPN: ✗ Disconnected"
        vpn_color="#FF0000"
    fi

    # Get GPU utilization (NVIDIA)
    if command -v nvidia-smi &> /dev/null; then
        gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
        gpu_mem=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null | head -1)

        if [ -n "$gpu_util" ]; then
            gpu_info="GPU: ${gpu_util}% ${gpu_temp}°C MEM: ${gpu_mem}%"
        else
            gpu_info="GPU: N/A"
        fi
    else
        gpu_info="GPU: N/A"
    fi

    # Prepend GPU and VPN info to the status line
    # i3bar expects JSON or plain text, we'll use plain text with color codes
    echo "$gpu_info | $vpn_info | $line" || exit 1
done
