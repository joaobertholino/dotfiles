#!/bin/bash

# Path to store the current output name
CURRENT_DEVICE_FILE="/tmp/polybar_current_audio_device"

# Function to get the current default sink
get_current_sink() {
pactl list sinks | grep -A 10 "Name: $sink" | grep "Description" | cut -d: -f2- | xargs    pactl info | grep 'Default Sink' | cut -d: -f2 | xargs
}

# Function to get a friendly name for the sink
get_sink_name() {
    local sink="$1"
    local description
    
    # Get the description/friendly name of the sink
    description=$(pactl list sinks | grep -A 10 "Name: $sink" | grep "Description" | cut -d: -f2- | xargs)
    
    # If description is too long, truncate it
    if [ ${#description} -gt 20 ]; then
				description="${description:0:10}"
    fi
    
    echo "$description"
}

# Function to switch to the next sink
switch_sink() {
    # Get list of all sinks
    local sinks=($(pactl list short sinks | cut -f1))
    local current_sink_id=$(get_current_sink)
    
    # Find the current sink in the list
    local current_index=-1
    for i in "${!sinks[@]}"; do
        if pactl list short sinks | grep "^${sinks[$i]}" | grep -q "$current_sink_id"; then
            current_index=$i
            break
        fi
    done
    
    # Calculate the next index (loop back to the beginning if necessary)
    local next_index=$(( (current_index + 1) % ${#sinks[@]} ))
    
    # Set the next sink as default
    pactl set-default-sink "${sinks[$next_index]}"
    
    # Move all currently playing streams to the new sink
    for app in $(pactl list short sink-inputs | cut -f1); do
        pactl move-sink-input "$app" "${sinks[$next_index]}"
    done
    
    # Update the stored name
    update_current_device
}

# Function to update the current device name file
update_current_device() {
    local current_sink=$(get_current_sink)
    local friendly_name=$(get_sink_name "$current_sink")
    echo "$friendly_name" > "$CURRENT_DEVICE_FILE"
}

# Function to display the current audio device
show_current_device() {
    if [ ! -f "$CURRENT_DEVICE_FILE" ]; then
        update_current_device
    fi
    
    cat "$CURRENT_DEVICE_FILE"
}

# Main logic
case "$1" in
    --toggle)
        switch_sink
        ;;
    --update)
        update_current_device
        ;;
    *)
        show_current_device
        ;;
esac
