# Workspaces e retorno da suspensão

Os workspaces fixos são explicitamente 1–5. Não usar `"*": 5`: a Waybar calcula a faixa a partir do ID do monitor; esse ID pode mudar após suspensão (por exemplo, de 0 para 1), deslocando a faixa para 6–10. Os demais workspaces continuam aparecendo quando existem.

A saída temporária FALLBACK é excluída da barra. A configuração aceita os demais monitores.

O serviço de usuário `waybar-resume-refresh.service` escuta PrepareForSleep do logind. Ao retomar, aguarda aproximadamente 2,5 segundos de estabilidade de uma saída real e então reinicia apenas waybar.service. A verificação só acontece após a retomada, por até 45 segundos; não há sondagem contínua. Uma nova suspensão cancela a verificação pendente.

Diagnóstico: `journalctl --user -u waybar-resume-refresh.service -u waybar.service`.
Atualização manual: `~/.local/libexec/waybar-resume-refresh --refresh`.
