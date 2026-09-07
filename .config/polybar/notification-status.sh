#!/usr/bin/env bash

if [ "$(dunstctl is-paused 2>/dev/null)" = "true" ]; then
  printf '%%{F#ff4d4d}%%{F-}'
else
  printf '%%{F#ffffff}%%{F-}'
fi
