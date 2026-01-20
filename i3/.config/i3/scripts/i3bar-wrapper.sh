#!/bin/bash

# i3bar wrapper with click event handling for volume control
# Adds GPU and VPN info, handles volume clicks

# Function to handle click events
handle_click() {
    while read -r line; do
        # Parse JSON click event
        name=$(echo "$line" | jq -r '.name // empty')
        button=$(echo "$line" | jq -r '.button // empty')

        # Handle volume clicks
        if [[ "$name" == "volume" ]]; then
            case "$button" in
                1)  # Left click - mute/unmute
                    amixer set Master toggle >/dev/null 2>&1
                    ;;
                4)  # Scroll up - increase volume
                    amixer set Master 5%+ >/dev/null 2>&1
                    ;;
                5)  # Scroll down - decrease volume
                    amixer set Master 5%- >/dev/null 2>&1
                    ;;
            esac
        fi
    done
}

# Start click event handler in background
handle_click &
CLICK_HANDLER_PID=$!

# Trap to kill click handler on exit
trap "kill $CLICK_HANDLER_PID 2>/dev/null" EXIT

# Send header with click_events enabled
echo '{"version":1,"click_events":true}'
echo '['
echo '[]'

# Run i3status and enhance its output
i3status -c ~/.config/i3status/config | while IFS= read -r line; do
    # Skip initial JSON protocol lines
    if [[ "$line" == "{"* ]] || [[ "$line" == "["* ]]; then
        continue
    fi

    # Remove leading comma if present
    line="${line#,}"

    # Parse the status line (it's a JSON array)
    if [[ "$line" == "["* ]]; then
        # Get VPN status
        vpn_status=$(nordvpn status 2>/dev/null | grep -i "Status:" | awk '{print $2}')
        if [[ "$vpn_status" == "Connected" ]]; then
            vpn_server=$(nordvpn status 2>/dev/null | grep -i "Current server:" | cut -d: -f2 | xargs)
            vpn_text="VPN: ✓ $vpn_server"
            vpn_color="#00FF00"
        else
            vpn_text="VPN: ✗"
            vpn_color="#FF0000"
        fi

        # Get GPU info if available
        if command -v nvidia-smi &> /dev/null; then
            gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_mem=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null | head -1)

            if [[ -n "$gpu_util" ]]; then
                gpu_text="GPU: ${gpu_util}% ${gpu_temp}°C MEM: ${gpu_mem}%"
            else
                gpu_text="GPU: N/A"
            fi
        else
            gpu_text=""
        fi

        # Build custom blocks
        custom_blocks=""

        if [[ -n "$gpu_text" ]]; then
            custom_blocks+="{\"full_text\":\" $gpu_text \",\"color\":\"#00AAFF\",\"separator\":true},"
        fi

        custom_blocks+="{\"full_text\":\" $vpn_text \",\"color\":\"$vpn_color\",\"separator\":true},"

        # Insert custom blocks into the array
        modified_line="${line#[}"
        modified_line="[${custom_blocks}${modified_line}"

        echo ",$modified_line"
    fi
done
