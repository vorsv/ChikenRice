#!/usr/bin/env bash

# Define a consistent notification ID for replacement
NID=9993

# Define an app name for mako rules (or dunst)
APP_NAME="HyprlandWorkspace"

# Function to show notification with custom sentences
show_workspace() {
    # Get active workspace info in JSON format
    local workspace_info=$(hyprctl activeworkspace -j)
    # Extract workspace ID (number)
    local workspace_id=$(echo "$workspace_info" | jq '.id')

    local sentence="" # Variable to hold the final sentence

    # ---vvv DEFINE YOUR CUSTOM SENTENCES PER WORKSPACE ID vvv---
    case "$workspace_id" in
        1) sentence="1. Fake it enough ,till the reality fades into it" ;;
        2) sentence="2. If you took a decision and you know you'll regret it ,then regret till God knows when" ;;
        3) sentence="3. I will go to hell rather forgive him" ;;
        4) sentence="4. Giving all the things that I hoped for but made me hate every moment of it" ;;
        5) sentence="5. When strange can't how you thought you could 😂😂" ;;
        6) sentence="6. The version i believed failed me" ;;
        7) sentence="7. You know its over when the world bleeds" ;;
        8) sentence="8. A Constructive end to no grasp in reality is I have lived infinite lives with you" ;;
        9) sentence="9. When you knew everything all along but you could not to interfere." ;;
       10) sentence="10.I shan't be trusted with me, let alone knife" ;;
       11) sentence=" Hmm what shall i say except ..." ;;

        # Add more cases for other workspace IDs if you use them

        # Default case for any workspace ID not listed above
        *) sentence="Workspace $workspace_id" ;; # Fallback to showing the ID
    esac
    # ---^^^ END OF CUSTOM SENTENCES ^^^---

    # Assign the chosen sentence to the display text variable
    local display_text="$sentence"

    # --- Send Notification ---
    # Send *only* the custom sentence as the main body of the notification
    notify-send -t 400 -r "$NID" -a "$APP_NAME" "$display_text"
}

# Ensure Hyprland environment variable is available
# This is needed to find the correct socket path
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    echo "Error: HYPRLAND_INSTANCE_SIGNATURE not set. Is Hyprland running?" >&2
    exit 1
fi

# Listen to Hyprland socket events using socat with process substitution
# This loop reads events from Hyprland's event socket 2
while read -r line; do
    # Check if the event is a workspace change (line starts with "workspace>>")
    case "$line" in
        workspace*)
            # Check if the part after "workspace" starts with ">>"
            suffix="${line#workspace}" # <<< REMOVED 'local' here
            if [[ "$suffix" == ">>"* ]]; then
                 # --- Actions for workspace>> event ---
                 echo "Workspace event detected! Time: $(date +%s.%N)" >> "$LOG_FILE" # Keep logging if using
                 echo "  -> Calling show_workspace function..." >> "$LOG_FILE"         # Keep logging if using
                 show_workspace &
                 # --- End Actions ---
            fi
            ;;
        # Optional: other cases
        # *)
        #    ;;
    esac
done < <(socat -u "UNIX-CONNECT:/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" -)

# If the loop exits (e.g., socat fails/disconnects), print a message to standard error
echo "Workspace notification script listener loop exited." >&2
