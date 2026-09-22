#!/usr/bin/env bash

VOICE_THRESHOLD=1300

if pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -qx 'Mute: yes'; then
  printf '%%{F#ff4d4d}•%%{F-}'
  exit 0
fi

level="$({ timeout 0.22s parec --raw --format=s16le --rate=8000 --channels=1 --latency-msec=20 2>/dev/null \
  | dd bs=1600 count=1 status=none \
  | od -An -t d2 \
  | awk '{ for (i = 1; i <= NF; i++) { value = $i; if (value < 0) value = -value; total += value; samples++ } } END { if (samples) printf "%d", total / samples; else print 0 }'; } 2>/dev/null)"

if [ "${level:-0}" -ge "$VOICE_THRESHOLD" ]; then
  printf '%%{F#00c853}•%%{F-}'
else
  printf '%%{F#666666}•%%{F-}'
fi
