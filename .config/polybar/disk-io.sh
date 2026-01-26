#!/bin/bash

# Defina seu disco (ex: nvme0n1, sda, sdb)
# Use o comando 'lsblk' para confirmar o nome
DISK="sdb"

# Pega os valores iniciais de setores lidos e escritos
read -r read1 write1 < <(awk -v disk="$DISK" '$3 == disk {print $6, $10}' /proc/diskstats)

# Aguarda 1 segundo para calcular a taxa
sleep 1

# Pega os valores finais
read -r read2 write2 < <(awk -v disk="$DISK" '$3 == disk {print $6, $10}' /proc/diskstats)

# Verifica se as variáveis não estão vazias para evitar erro de sintaxe
if [[ -n "$read1" && -n "$read2" && -n "$write1" && -n "$write2" ]]; then
    # Cálculo em KB/s (cada setor tem 512 bytes)
    # R = (final - inicial) * 512 / 1024 / tempo
    calc_read=$(( (read2 - read1) * 512 / 1024 ))
    calc_write=$(( (write2 - write1) * 512 / 1024 ))
    echo "R: ${calc_read} KB/s W: ${calc_write} KB/s"
else
    echo "Disco $DISK não encontrado"
fi

