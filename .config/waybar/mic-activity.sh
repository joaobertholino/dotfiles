#!/usr/bin/env bash

if pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -qx 'Mute: yes'; then
  printf '%s\n' '{"text":"•","class":"red","tooltip":"Microfone desativado"}'
  exit 0
fi

printf '%s\n' '{"text":"•","class":"green","tooltip":"Microfone ativado"}'
