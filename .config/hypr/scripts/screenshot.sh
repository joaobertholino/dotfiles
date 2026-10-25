#!/usr/bin/env bash
set -euo pipefail
mode=${1:-region}
case "$mode" in region|window|output) ;; *) exit 64 ;; esac
directory="$HOME/Images/screenshots"
mkdir -p "$directory"
args=(-m "$mode" -o "$directory" -f "$(date '+%d-%m-%YT%H-%M-%S-%N').png")
if [[ ${2:-} == clipboard ]]; then args+=(--clipboard-only); fi
exec /usr/local/bin/hyprshot "${args[@]}"
