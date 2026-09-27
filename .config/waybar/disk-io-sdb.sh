#!/usr/bin/env bash

disk="sdb"
read -r read_before write_before < <(awk -v disk="$disk" '$3 == disk {print $6, $10}' /proc/diskstats)
sleep 1
read -r read_after write_after < <(awk -v disk="$disk" '$3 == disk {print $6, $10}' /proc/diskstats)

if [[ -n "$read_before" && -n "$read_after" && -n "$write_before" && -n "$write_after" ]]; then
    printf 'R: %s KB/s W: %s KB/s\n' "$(( (read_after - read_before) * 512 / 1024 ))" "$(( (write_after - write_before) * 512 / 1024 ))"
else
    printf 'Disco %s não encontrado\n' "$disk"
fi
