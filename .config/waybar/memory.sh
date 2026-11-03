#!/bin/sh
value=$(awk '/MemTotal:/ {t=$2} /MemAvailable:/ {a=$2} END {printf "%d",(t-a)/1024}' /proc/meminfo)
printf '<span font_desc="Font Awesome 7 Free Solid 10"></span> %s MB\n' "$value"
