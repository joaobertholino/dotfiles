#!/usr/bin/env bash

awk '
  /MemTotal:/ { total = $2 }
  /MemAvailable:/ { available = $2 }
  END { printf "RAM: %d MB", (total - available) / 1024; print "" }
' /proc/meminfo
