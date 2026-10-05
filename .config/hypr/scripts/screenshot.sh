#!/usr/bin/env bash

set -u

directory="/home/joaob/Images/screenshots"
filename="$(date '+%d-%m-%YT%H-%M-%S').png"

mkdir -p "$directory"

# hyprshot mantém o seletor de região em primeiro plano até a seleção ser
# concluída. Cancelar com Esc não cria um arquivo parcial.
hyprshot -m region -o "$directory" -f "$filename" -s -z
