#!/usr/bin/env bash

set -u

directory="/home/joaob/Images/screenshots"
filename="$(date '+%d-%m-%YT%H-%M-%S').png"

mkdir -p "$directory"

# O seletor abre diretamente sobre a área de trabalho, sem congelar/animação.
# Cancelar com Esc não cria um arquivo parcial.
hyprshot -m region -o "$directory" -f "$filename" -s
