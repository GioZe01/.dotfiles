#!/bin/bash

# i3bar wrapper with volume click support
# This wrapper reads click events from stdin and modifies i3status output

# Enable click events
echo '{"version":1,"click_events":true}'
echo '['
echo '[]'

# Start i3status in the background
i3status -c ~/.config/i3status/config 2>/dev/null | while IFS= read -r line; do
    # Skip JSON protocol lines
    [[ "$line" =~ ^{\"version\" ]] && continue
    [[ "$line" =~ ^\[ ]] && [[ ! "$line" =~ ^\[\{ ]] && continue

    # Remove leading comma
    line="${line#,}"

    # If this is a status line (JSON array)
    if [[ "$line" =~ ^\[\{ ]]; then
        # Get VPN status
        vpn_status=$(nordvpn status 2>/dev/null | grep -i "Status:" | awk '{print $2}')
        if [[ "$vpn_status" == "Connected" ]]; then
            vpn_server=$(nordvpn status 2>/dev/null | grep -i "Current server:" | cut -d: -f2 | xargs | cut -d. -f1)
            vpn_json="{\"full_text\":\" VPN: ✓ $vpn_server \",\"color\":\"#00FF00\"}"
        else
            vpn_json="{\"full_text\":\" VPN: ✗ \",\"color\":\"#FF0000\"}"
        fi

        # Get GPU info
        if command -v nvidia-smi &>/dev/null; then
            gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)
            gpu_mem=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null | head -1)

            if [[ -n "$gpu_util" ]]; then
                gpu_json="{\"full_text\":\" GPU: ${gpu_util}% ${gpu_temp}°C MEM: ${gpu_mem}% \",\"color\":\"#00AAFF\"}"
            else
                gpu_json=""
            fi
        else
            gpu_json=""
        fi

        # Parse the i3status JSON array and add name to volume
        modified=$(echo "$line" | python3 -c '
import sys, json
try:
    data = json.load(sys.stdin)
    for block in data:
        if "volume" in block.get("full_text", "").lower() or "♪" in block.get("full_text", ""):
            block["name"] = "volume"
            block["instance"] = "master"
    print(json.dumps(data))
except:
    print(sys.stdin.read())
' 2>/dev/null)

        # If python parsing failed, use original line
        if [[ -z "$modified" ]] || [[ "$modified" == "null" ]]; then
            modified="$line"
        fi

        # Remove the closing bracket
        modified="${modified%]}"

        # Build final output
        output="["
        [[ -n "$gpu_json" ]] && output+="$gpu_json,"
        output+="$vpn_json,"
        output+="${modified#[}"
        output+="]"

        echo ",$output"
    fi
done &

I3STATUS_PID=$!

# Handle click events from i3bar
while read -r line; do
    # Parse click event
    if echo "$line" | grep -q '"name"'; then
        name=$(echo "$line" | python3 -c 'import sys,json; print(json.loads(sys.stdin.read()).get("name",""))' 2>/dev/null)
        button=$(echo "$line" | python3 -c 'import sys,json; print(json.loads(sys.stdin.read()).get("button",""))' 2>/dev/null)

        # Handle volume clicks
        if [[ "$name" == "volume" ]]; then
            case "$button" in
                1)  # Left click - toggle mute
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
    fi
done

# Kill i3status when this script exits
kill $I3STATUS_PID 2>/dev/null
