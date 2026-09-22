#!/bin/bash

DISK="sda"

read -r read1 write1 < <(awk -v disk="$DISK" '$3 == disk {print $6, $10}' /proc/diskstats)

sleep 1

read -r read2 write2 < <(awk -v disk="$DISK" '$3 == disk {print $6, $10}' /proc/diskstats)

if [[ -n "$read1" && -n "$read2" && -n "$write1" && -n "$write2" ]]; then
    calc_read=$(( (read2 - read1) * 512 / 1024 ))
    calc_write=$(( (write2 - write1) * 512 / 1024 ))
    echo "R: ${calc_read} KB/s W: ${calc_write} KB/s"
else
    echo "Disco $DISK não encontrado"
fi
