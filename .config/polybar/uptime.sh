#!/bin/bash

# Get uptime in seconds from /proc/uptime
uptime_seconds=$(awk '{print int($1)}' /proc/uptime)

# Calculate days, hours, minutes, and seconds
days=$((uptime_seconds / 86400))
hours=$(( (uptime_seconds % 86400) / 3600 ))
minutes=$(( (uptime_seconds % 3600) / 60 ))
seconds=$((uptime_seconds % 60))

# Format the output
if [ "$days" -gt 0 ]; then
    printf "%d:%d:%d:%ds" "$days" "$hours" "$minutes" "$seconds"
else
    printf "%d:%d:%d" "$hours" "$minutes" "$seconds"
fi
