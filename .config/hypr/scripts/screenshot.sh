#!/usr/bin/env bash

directory="/home/joaob/Images/screenshots"
file="$directory/$(date '+%d-%m-%YT%H-%M-%S').png"
mkdir -p "$directory"
grim -g "$(slurp)" "$file" && wl-copy < "$file"
