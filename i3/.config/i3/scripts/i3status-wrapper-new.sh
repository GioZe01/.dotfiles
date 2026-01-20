#!/bin/bash

# i3status wrapper with click event handling
# Adds NordVPN status, GPU info, and volume click controls

# Send the header so that i3bar knows we want to use JSON
echo '{"version":1,"click_events":true}'

# Begin the infinite array
echo '['

# Empty first array element
echo '[],'

# Start i3status and process its output
i3status -c ~/.config/i3status/config | while :
do
    read line

    # Skip the initial header lines from i3status
    if [[ "$line" == "{"* ]] || [[ "$line" == "["* ]] || [[ "$line" == "]*" ]]; then
        continue
    fi

    # Remove leading comma and whitespace
    line="${line#,}"
    line="${line#"${line%%[![:space:]]*}"}"

    # Parse the JSON array
    if [[ "$line" == "["* ]]; then
        # Get VPN status
        vpn_status=$(nordvpn status 2>/dev/null | grep Status | awk '{print $2}')
        if [ "$vpn_status" = "Connected" ]; then
            vpn_server=$(nordvpn status | grep "Current server" | awk '{print $3}')
            vpn_text="VPN: ✓ $vpn_server"
            vpn_color="#00FF00"
        else
            vpn_text="VPN: ✗"
            vpn_color="#FF0000"
        fi

        # Get GPU utilization (NVIDIA)
        if command -v nvidia-smi &> /dev/null; then
            gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_mem=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null | head -1)

            if [ -n "$gpu_util" ]; then
                gpu_text="GPU: ${gpu_util}% ${gpu_temp}°C MEM: ${gpu_mem}%"
            else
                gpu_text="GPU: N/A"
            fi
        else
            gpu_text="GPU: N/A"
        fi

        # Create custom blocks
        gpu_block="{\"full_text\":\" $gpu_text \",\"color\":\"#00AAFF\",\"separator\":true,\"separator_block_width\":15}"
        vpn_block="{\"full_text\":\" $vpn_text \",\"color\":\"$vpn_color\",\"separator\":true,\"separator_block_width\":15}"

        # Insert custom blocks at the beginning of the array
        modified_line="${line#[}"  # Remove opening bracket
        echo ",[${gpu_block},${vpn_block},${modified_line}" || exit 1
    else
        echo ",$line" || exit 1
    fi
done
