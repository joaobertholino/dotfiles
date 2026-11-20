# Abas do Hyprland

Configuração: modules/tabs.lua. As abas são grupos de janelas do compositor; cada documento continua em sua própria janela do aplicativo.

| Atalho | Ação |
| --- | --- |
| Super + Ctrl + G | Criar grupo ou desfazer o grupo atual |
| Super + Ctrl + Shift + G | Reunir janelas livres do mesmo aplicativo no workspace atual |
| Super + Ctrl + Tab | Próxima aba |
| Super + Ctrl + Shift + Tab | Aba anterior |
| Super + Ctrl + U | Retirar a janela atual do grupo |
| Super + Ctrl + Shift + L | Bloquear/desbloquear a entrada de janelas no grupo |

Super é a tecla Windows. Super + Tab continua alternando entre workspaces.

Clique no título da aba ou role sobre a barra para alternar. Para adicionar uma janela existente, arraste-a com Super + botão esquerdo até a barra de abas. Novas janelas entram no grupo focado se ele estiver desbloqueado. O clique do meio não fecha abas; Super + W fecha a janela atual usando o atalho habitual.

No Xournal++, abra cada documento em uma janela separada (Super + Alt + X inicia outra janela), e use Super + Ctrl + Shift + G para reuni-las no workspace atual. Abrir um documento por Arquivo > Abrir ainda segue o comportamento do Xournal++, substituindo o documento daquela janela.

Validação: configuração recarregada sem erros; agrupamento de duas janelas temporárias, alternância em ambos os sentidos e retirada de uma aba testados pela API nativa do Hyprland 0.57.1.
