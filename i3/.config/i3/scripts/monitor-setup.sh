#!/bin/bash

# Auto-detect and configure monitors for i3

# Get connected monitors
MONITORS=$(xrandr | grep " connected" | awk '{print $1}')
MONITOR_COUNT=$(echo "$MONITORS" | wc -l)

echo "Detected $MONITOR_COUNT monitor(s)"

if [ "$MONITOR_COUNT" -eq 1 ]; then
    # Single monitor - just enable it
    PRIMARY=$(echo "$MONITORS" | head -n 1)
    xrandr --output "$PRIMARY" --auto --primary
    echo "Single monitor setup: $PRIMARY"
elif [ "$MONITOR_COUNT" -eq 2 ]; then
    # Dual monitor - set side by side
    PRIMARY=$(echo "$MONITORS" | head -n 1)
    SECONDARY=$(echo "$MONITORS" | tail -n 1)

    # Primary on left, secondary on right
    xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --auto --right-of "$PRIMARY"
    echo "Dual monitor setup: $PRIMARY (primary) + $SECONDARY (right)"
elif [ "$MONITOR_COUNT" -ge 3 ]; then
    # Three or more monitors - arrange in a row
    PRIMARY=$(echo "$MONITORS" | head -n 1)
    xrandr --output "$PRIMARY" --auto --primary

    PREVIOUS="$PRIMARY"
    for MONITOR in $(echo "$MONITORS" | tail -n +2); do
        xrandr --output "$MONITOR" --auto --right-of "$PREVIOUS"
        PREVIOUS="$MONITOR"
    done
    echo "Multi-monitor setup: monitors arranged in a row"
fi

# Set wallpaper on all monitors
feh --bg-scale ~/Pictures/wallpaper.jpg || true
