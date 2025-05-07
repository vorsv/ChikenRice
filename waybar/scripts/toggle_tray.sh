#!/bin/bash

# Check if stalonetray process exists
if pgrep -x "stalonetray" > /dev/null
then
    # If it exists, kill it
    pkill -x "stalonetray"
else
    # If it doesn't exist, start it
    # Adjust geometry, background, icon size etc. as needed
    # Example: Place it near the top-right corner.
    # You might need to experiment with the --geometry option.
    # Format: WxH+X+Y (e.g., 1x1+1800+45 positions it below the bar near the right)
    # `-bg "#000000"` sets background (use your bar's color)
    # `--klassy` helps with window manager rules
    # `--grow-gravity NE` tries to align icons top-right within the tray window
    # `--icon-gravity NE` aligns the icons themselves
    # You MUST configure stalonetray further via its config file or command line args
    stalonetray \
        --config "$HOME/.config/stalonetray/stalonetrayrc" &
        # Example command-line args if not using config file:
        # --geometry 1x1+1800+45 \
        # --icon-size 20 \
        # --background "#282A36" \ # Match your bar background
        # --klassy "stalonetray" \
        # --window-layer "top" \
        # --grow-gravity "NE" \
        # --icon-gravity "NE" \
        # --transparent \ # May require a compositor that supports it
        # --no-shrink \
        # --skip-taskbar \
        # --sticky \
        # &
fi

exit 0
