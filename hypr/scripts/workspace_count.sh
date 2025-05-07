HYPRCTL_PATH="/usr/bin/hyprctl" # PASTE YOUR 'which hyprctl' OUTPUT HERE
JQ_PATH="/usr/bin/jq"           # PASTE YOUR 'which jq' OUTPUT HERE

# Check if commands exist (optional but good practice)
if [ ! -x "$HYPRCTL_PATH" ]; then
  echo '{"text":"ERR","tooltip":"hyprctl not found"}'
  exit 1
fi
if [ ! -x "$JQ_PATH" ]; then
  echo '{"text":"ERR","tooltip":"jq not found"}'
  exit 1
fi

# Execute the command using full paths
$HYPRCTL_PATH clients -j | $JQ_PATH -c '( [.[].workspace.id] | map(select(. > 0 and . <= 10)) | unique | sort ) as $ids | ($ids | length) as $count | "Active  (\($count)): \($ids | join(", "))" as $tooltip_text | {"text": ($count | tostring), "tooltip": $tooltip_text}' || echo '{"text":"ERR","tooltip":"Error running hyprctl or jq"}'

exit 0
