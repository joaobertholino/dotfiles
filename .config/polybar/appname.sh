#!/bin/bash

# Get window ID of the focused window
id=$(xprop -root | grep '^_NET_ACTIVE_WINDOW(WINDOW)' | cut -d' ' -f5)

# If no window is focused (e.g. looking at desktop)
if [[ "$id" == "0x0" || -z "$id" ]]; then
    echo "Desktop"
    exit 0
fi

# Get the window class (usually the application name)
class=$(xprop -id "$id" WM_CLASS 2>/dev/null | sed -e 's/^.*", "\(.*\)"$/\1/')

# If we couldn't get the class, try getting the name as fallback
if [[ -z "$class" ]]; then
    name=$(xprop -id "$id" WM_NAME 2>/dev/null | cut -d'"' -f2)
    echo "$name"
else
    # Capitalize first letter and output
    echo "$class" | sed 's/./\u&/'
fi

