#!/usr/bin/env bash

set -euo pipefail

monitor="HDMI-A-1"
transform=$(hyprctl monitors -j | jq -r --arg monitor "$monitor" '.[] | select(.name == $monitor) | .transform')

if [[ "$transform" == "0" ]]; then
  # 1 is a 90-degree clockwise portrait transform. Hyprland retains its configured animations.
  hyprctl keyword monitor "$monitor,1920x1080@120,auto,1,1"
  sed -i 's/^[[:space:]]*transform = [0-9],/    transform = 1,/' /home/joaob/.config/hypr/modules/monitors.lua
  notify-send --app-name=Hyprland 'Orientação da tela' 'Vertical'
else
  hyprctl keyword monitor "$monitor,1920x1080@120,auto,1,0"
  sed -i 's/^[[:space:]]*transform = [0-9],/    transform = 0,/' /home/joaob/.config/hypr/modules/monitors.lua
  notify-send --app-name=Hyprland 'Orientação da tela' 'Horizontal'
fi
