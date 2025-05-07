#!/bin/bash

GOVERNORS=("performance" "powersave")
CURRENT_GOVERNOR=$(cpupower frequency-info -c 0 | grep "current policy:" | awk '{print $4}')

if [ "$CURRENT_GOVERNOR" == "${GOVERNORS[0]}" ]; then
  NEXT_GOVERNOR="${GOVERNORS[1]}"
else
  NEXT_GOVERNOR="${GOVERNORS[0]}"
fi

sudo cpupower frequency-set -g "$NEXT_GOVERNOR"
notify-send "CPU Governor Switched to: $NEXT_GOVERNOR"
