#!/usr/bin/env bash

pactl set-source-mute @DEFAULT_SOURCE@ toggle

if pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -qx 'Mute: yes'; then
  notify-send --app-name=Polybar --icon=audio-input-microphone \
    'Microfone desativado' 'Clique no ponto vermelho para ativá-lo.'
else
  notify-send --app-name=Polybar --icon=audio-input-microphone \
    'Microfone ativado' 'O ponto ficará verde quando detectar voz.'
fi
