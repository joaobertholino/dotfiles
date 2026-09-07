#!/usr/bin/env bash

if [ "$(dunstctl is-paused 2>/dev/null)" = "true" ]; then
  dunstctl set-paused false
else
  dunstctl set-paused true
fi
