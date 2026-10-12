#!/usr/bin/env bash

set -u

directory="/home/joaob/Images/screenshots"
filename="$(date '+%d-%m-%YT%H-%M-%S').png"

mkdir -p "$directory"

hyprshot -m region -o "$directory" -f "$filename" -s
