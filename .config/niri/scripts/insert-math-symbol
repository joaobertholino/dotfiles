#!/usr/bin/env bash

# Copia o símbolo e o cola no aplicativo em foco pelo atalho padrão Ctrl+V.
set -euo pipefail

symbol=${1:?"Informe um símbolo matemático"}
printf '%s' "$symbol" | wl-copy
# Aguarda a liberação de Super+Alt antes de enviar Ctrl+V ao campo ativo.
sleep 0.35
wtype -M ctrl -k v -m ctrl
