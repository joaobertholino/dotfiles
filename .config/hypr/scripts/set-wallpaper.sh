#!/usr/bin/env bash

# Set and persist an image from any directory for a Hyprpaper-managed monitor.
# Usage: set-wallpaper.sh IMAGE [MONITOR] [cover|contain|fill|tile]

set -euo pipefail

usage() {
    printf 'Uso: %s IMAGEM [MONITOR] [cover|contain|fill|tile]\n' "${0##*/}" >&2
    exit 64
}

[[ $# -ge 1 && $# -le 3 ]] || usage

image=$(realpath -- "$1")
monitor=${2:-HDMI-A-1}
fit_mode=${3:-cover}
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprpaper.d"
selected_config="$config_dir/selected-wallpaper.conf"

[[ -f "$image" && -r "$image" ]] || {
    printf 'Imagem inválida ou sem permissão de leitura: %s\n' "$1" >&2
    exit 66
}

case "$fit_mode" in
    cover|contain|fill|tile) ;;
    *) usage ;;
esac

# Hyprpaper's IPC protocol uses commas as delimiters and its config is
# line-based, so reject the two filename forms it cannot represent safely.
[[ "$image" != *$'\n'* && "$image" != *,* ]] || {
    printf 'O caminho da imagem não pode conter vírgula nem quebra de linha.\n' >&2
    exit 65
}

mkdir -p -- "$config_dir"

temp_config=$(mktemp "$config_dir/.selected-wallpaper.XXXXXX")
trap 'rm -f -- "$temp_config"' EXIT

{
    printf '# Gerado por %s; não edite enquanto o helper estiver em uso.\n' "${0##*/}"
    printf 'wallpaper {\n'
    printf '    monitor = %s\n' "$monitor"
    printf '    path = %s\n' "$image"
    printf '    fit_mode = %s\n' "$fit_mode"
    printf '}\n'
} > "$temp_config"
mv -f -- "$temp_config" "$selected_config"

# Apply immediately when the current graphical session is available.  The
# saved file also applies automatically the next time Hyprpaper starts.
if hyprctl hyprpaper wallpaper "$monitor, $image, $fit_mode"; then
    notify-send --app-name=Hyprpaper 'Papel de parede atualizado' "${image##*/}" 2>/dev/null || true
else
    printf 'Configuração salva em %s; ela será aplicada ao iniciar o Hyprpaper.\n' "$selected_config" >&2
fi
