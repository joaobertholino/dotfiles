# Dotfiles — Gentoo + Hyprland

Configurações pessoais do desktop Gentoo Linux com Hyprland/Wayland, Bash, Waybar, Alacritty, Doom Emacs e Xournal++. Integração da sessão e do Portage atualizada em **26/10/2026**.

![Desktop Gentoo Linux com Hyprland](https://i.imgur.com/gtIDuco.png)

O repositório principal tem sua árvore de trabalho em `~/`. O `.gitignore` permite apenas os arquivos de configuração selecionados; documentos, credenciais, chaves SSH, caches e estado local ficam fora do versionamento. Este projeto não contém um instalador completo do sistema.

## Organização

| Caminho | Conteúdo |
| --- | --- |
| `.bashrc`, `.bash_aliases`, `.bash_profile`, `.profile` | Ambiente Bash e aliases Gentoo/Nix |
| `.config/hypr/` | Entrada Lua, módulos, atalhos, captura e papel de parede |
| `.config/waybar/` | Painel, relógio, métricas e áudio |
| `.config/alacritty/`, `.config/tmux/` | Terminal e sessão tmux `main` |
| `.config/Thunar/` | Ações personalizadas e atalhos do gerenciador de arquivos |
| `.config/xfce4/xfconf/xfce-perchannel-xml/thunar*.xml` | Preferências do Thunar e Volman |
| `.config/systemd/user/` | Unidades versionadas de Thunar, Tumbler e push automático; serviços da sessão instalados localmente |
| `.local/share/dbus-1/services/` | Ativação dos serviços Thunar e Tumbler |
| `.local/bin/auto-push.sh` | Commit e push recursivo dos dotfiles |
| `.config/zathura/`, `.config/htop/`, `.config/gigolo/` | Configurações de aplicativos |

Existem arquivos e aliases herdados do Arch, como `.config/yay/` e atalhos para `yay`. Eles não constituem o método de instalação do Gentoo atual.

## Submódulos

| Diretório | Repositório | Finalidade |
| --- | --- | --- |
| `.config/doom` | [doom](https://github.com/joaobertholino/doom) | Configuração pessoal do Doom Emacs |
| `.config/xournalpp` | [xournalpp](https://github.com/joaobertholino/xournalpp) | Preferências, paletas e modelos de anotação |
| `.config/dunst` | [Dunst](https://github.com/joaobertholino/Dunst) | Tema das notificações |
| `.config/zen-cal` | [zen-cal](https://github.com/joaobertholino/zen-cal) | Calendário do relógio da Waybar |

Os quatro diretórios são submódulos Git, não cópias comuns. As URLs em `.gitmodules` usam SSH e exigem autenticação no GitHub.

## Obter e adaptar as configurações

Para avaliar o projeto, clone em um diretório separado e vazio:

```sh
git clone --recurse-submodules https://github.com/joaobertholino/dotfiles.git "$HOME/src/dotfiles"
```

Antes de usar os arquivos, faça backup das configurações existentes e revise os caminhos pessoais. A implantação desta máquina mantém o Git em `~/.git`; não tente clonar diretamente sobre uma home preenchida nem copiar ponteiros `.git` de submódulos entre diretórios. Para instalar um submódulo isoladamente, siga seu README e use um destino vazio após o backup.

Pontos que precisam de adaptação em outro computador:

- `/home/joaob` nos módulos Hyprland, scripts e Waybar;
- monitor `HDMI-A-1`, modo `1920x1080@120`, rotação `transform = 1`, configuração de cor e tablet;
- fontes 0xProto Nerd Font, Noto Sans, Wigrum e tema de ícones `bloom-dark`;
- diretórios pessoais de LaTeX, bibliografia, notas e projetos;
- caminhos absolutos `/opt/`, `/usr/local/bin/` e `/nix/store/` usados pela instalação local.

A configuração usa a API Lua `hl` do Hyprland 0.56.2 instalado nesta máquina. Não deve ser aplicada sem adaptação a uma versão que só aceite a sintaxe tradicional de `hyprland.conf`.

## Pacotes e binários da máquina

O sistema combina pacotes nativos do Gentoo com binários pré-compilados do Nix e distribuições oficiais. A política local do Nix define `max-jobs = 0` e `fallback = false`, impedindo que instalações sem substituto binário iniciem uma compilação local.

Componentes presentes incluem Hyprland, Hyprpaper, Hyprshot, Hyprlauncher, Hyprpicker, Hyprpwcenter, Hyprsysteminfo, Hyprpolkitagent, portal Hyprland, PipeWire/WirePlumber, Waybar, Alacritty e tmux.

Ferramentas de desenvolvimento instaladas: Lean 4.35.0 com Lake, Common Lisp/SBCL 2.6.8 e Eclipse Temurin JDK 27.0.1.0.2+1. `JAVA_HOME` aponta para `/opt/jdk-current`. As versões descrevem esta instalação, não dependências fixadas pelo repositório.

Os binários, wrappers e arquivos globais não são instalados por este checkout. Na máquina atual, podem ser consultados em `/opt/hyprland/`, `/opt/thunar/`, `/opt/development/`, `/usr/local/bin/` e `/usr/local/share/gentoo-install/`. Esses caminhos e os inventários locais não fazem parte do repositório.

### Aliases de pacotes

| Comando | Função |
| --- | --- |
| `ebin categoria/pacote` | Instalar pelo Portage somente com binários |
| `ei categoria/pacote` | Instalação normal pelo Portage; pode compilar |
| `es termo` | Pesquisar no Portage |
| `esync` | Sincronizar repositórios Gentoo |
| `ni nixpkgs#pacote` | Instalar binário no perfil `/opt/nix-profile` |
| `ns termo` | Pesquisar no Nixpkgs |
| `nl` | Listar pacotes desse perfil Nix |
| `nu` | Atualizar o perfil Nix usando binários |
| `nr pacote` | Remover pacote do perfil |
| `nh` / `nrollback` | Histórico / retorno à geração anterior |
| `ngc` | Remover objetos sem referências no armazenamento Nix |

Os atalhos Nix usam `sudo` porque esta instalação mantém o armazenamento sob administração do root. O perfil `/opt/nix-profile` é separado das instalações mantidas diretamente em `/opt/hyprland/`, `/opt/thunar/` e `/opt/development/`.

## Interface gráfica do Portage: Kuroo

A máquina tem `app-portage/kuroo-1.2.4::gentoo`, frontend Qt 6/KDE Frameworks 6 do repositório oficial Gentoo. Essa versão tem keyword `~amd64`; a aceitação local está restrita a `=app-portage/kuroo-1.2.4` em `/etc/portage/package.accept_keywords/kuroo`. Não foi habilitado testing para o sistema inteiro nem adicionado overlay para esse pacote.

```sh
emerge -pv =app-portage/kuroo-1.2.4
kuroo --version
kuroo
```

O lançador `/usr/local/bin/kuroo` usa `/usr/bin/kuroo` com Qt/Wayland nativo, limpa variáveis gráficas Nix incompatíveis e aplica o grupo `portage` ao processo com `sg` quando a sessão ainda não herdou a associação. O usuário precisa estar cadastrado nesse grupo. Não execute a interface como root.

Os dados ficam em `/var/cache/kuroo`, com backup em `/var/cache/kuroo/backup`; ambos permitem escrita ao grupo `portage` e herdam esse grupo com modo `2770`. A configuração pessoal fica em `~/.config/kuroorc`. Na primeira atualização do banco de dados, confirme **Refresh** para carregar os pacotes; uma janela aberta não confirma que todas as funções administrativas foram testadas.

A conta root desta instalação está bloqueada. A regra local `/etc/polkit-1/rules.d/40-kuroo-admin.rules` permite autenticar as cinco ações administrativas do Kuroo com a senha de `joaob`, apenas em sessão local ativa e com participação no grupo `wheel`. Ela seleciona a identidade administrativa; a senha continua obrigatória. A autenticação de criação do diretório foi confirmada no journal.

Para corrigir a descoberta de repositórios, `repoLocations` do Kuroo contém os caminhos obtidos do Portage e `/etc/portage/repos.conf/gentoo.conf` explicita a localização já usada `/var/db/repos/gentoo`. Localização, tipo/URI de sincronização, auto-sync e prioridade efetivos foram comparados antes/depois e permaneceram iguais.

O lançador, a regra Polkit, o cadastro de grupos, os diretórios de dados e esses arquivos locais de Portage/Kuroo não são fornecidos por este checkout. Avisos internos de QProcess/SQLite foram observados; não foram feitas instalações ou remoções pela GUI durante a validação. Em outra máquina, verifique versão, keyword e dependências antes de instalar.

## Doom Emacs como editor padrão

A configuração pessoal está no submódulo `.config/doom`; o framework Doom está em `~/.config/emacs`. O daemon `emacs.service` atende os clientes.

Na máquina atual:

- `EDITOR=/usr/local/bin/doom-editor-terminal` abre um cliente no terminal;
- `VISUAL=/usr/local/bin/doom-editor` abre um frame gráfico;
- o Git usa `/usr/local/bin/doom-editor` como `core.editor`;
- arquivos de texto e código selecionados estão associados a `doom-emacs.desktop`;
- o ambiente persistente é definido em `/etc/env.d/50emacs` e propagado ao Hyprland.

Os wrappers, a entrada desktop e a unidade global do Emacs precisam ser recriados em outra instalação; não são fornecidos pelo submódulo. Depois de alterar módulos ou pacotes Emacs, execute `doom sync`. Consulte o [README do Doom](.config/doom/README.md).

## Thunar e arquivos compactados

O Thunar 4.20.10 utiliza uma pilha binária Nix consistente para os plugins Archive, Media Tags, VCS, Shares e Dropbox. Thunar Volman gerencia mídias removíveis; Tumbler fornece miniaturas; GVfs integra arquivos virtuais e acesso aos serviços de montagem.

Ações personalizadas em `.config/Thunar/uca.xml`:

- abrir Alacritty na pasta selecionada;
- calcular checksums com GtkHash;
- aplicar imagens como papel de parede pelo Hyprpaper;
- **Extrair TAR aqui**, incluindo `.tar`, `.tar.gz`, `.tar.bz2`, `.tar.xz`, `.tar.zst` e variantes relacionadas.

File Roller é o aplicativo padrão para TAR e outros formatos compactados. As associações MIME estão configuradas localmente em `~/.config/mimeapps.list`, fora da lista de arquivos versionados. O GtkHash foi integrado por ação personalizada; o pacote binário disponível não inclui seu módulo Thunar específico.

O suporte Shares utiliza Samba/usershares. Para autenticar seu usuário pela rede, defina uma senha Samba com `sudo smbpasswd -a joaob`; a configuração não cria uma senha nem compartilha uma pasta automaticamente. A extensão Dropbox depende do cliente em execução e da autenticação da conta.

## Sessão, notificações e calendário

O módulo `.config/hypr/modules/startup.lua` chama `/usr/local/bin/gentoo-session-start` quando o compositor está pronto. Esse helper apenas importa o ambiente Wayland para D-Bus/systemd e ativa `hyprland-session.target`. Os aplicativos de início da sessão são executados e supervisionados pelo **systemd do usuário**; não há lançamento direto desses daemons por `exec-once` ou pelo helper.

| Componente | Serviço de usuário |
| --- | --- |
| Painel Waybar | `waybar.service` |
| Notificações Dunst | `dunst.service` |
| Lançador Hyprlauncher | `hyprlauncher.service` |
| Indicador de rede | `nm-applet.service` |
| Papel de parede awww/Waypaper | `gentoo-animated-wallpaper.service` |
| Agente de autenticação | `hyprpolkitagent.service` |

Os seis serviços estão habilitados no `hyprland-session.target`, ligado a `graphical-session.target`. `hyprland-session-guard.service` acompanha o PID da instância atual do compositor; quando ela termina, o target e seus aplicativos são encerrados. O helper importa display, IPC, temas, cursores e bibliotecas da sessão antes de ativar o conjunto. A instalação atual usa essa integração local, sem UWSM.

O papel de parede ativo é restaurado com `waypaper --restore` sobre o daemon `awww`; o helper tem como alternativa o GIF `~/.local/share/wallpapers/gentoo-violet-orbit-vertical-hd.gif`. Os arquivos `hyprpaper.conf` e `hyprpaper.d/` continuam no checkout, mas não descrevem o daemon ativo.

Comandos de consulta e manutenção na sessão gráfica já preparada:

```sh
systemctl --user status hyprland-session.target
systemctl --user status waybar dunst hyprlauncher nm-applet gentoo-animated-wallpaper hyprpolkitagent
systemctl --user restart waybar.service
systemctl --user reload waybar.service
journalctl --user -u waybar.service -b
```

Reiniciar `hyprland-session.target` reinicia todos os componentes vinculados, incluindo notificações e papel de parede. Para uma alteração em apenas um aplicativo, reinicie sua unidade. Foram verificados início/parada do conjunto e uma única instância de cada componente; a Waybar também foi testada com recuperação automática após falha. O logout/login completo não foi executado durante esses testes.

**Limite do checkout:** o helper em `/usr/local/bin`, o monitor em `~/.local/libexec/hyprland-session-guard`, `~/.local/bin/apply-gentoo-wallpaper`, as novas unidades/targets e seus drop-ins não estão versionados neste repositório. O `.gitignore` de `systemd/user` atualmente permite apenas Thunar, Tumbler e push automático. Em outra máquina, recrie e adapte essa integração antes de usar o hook Lua; clonar os dotfiles não instala esses serviços. Não adicione um segundo início de Waybar, Dunst, Hyprlauncher ou nm-applet no Hyprland enquanto seus serviços estiverem ativos.

PipeWire, WirePlumber, portais e o daemon Emacs já usam unidades systemd separadas. Aplicativos abertos por atalhos e o calendário aberto por clique continuam sob demanda.

O relógio da Waybar chama `.config/zen-cal/toggle.sh`; a regra da janela é carregada por `.config/hypr/modules/rules.lua`. O clique esquerdo alterna o calendário. O clique direito aciona o formato alternativo do relógio, que atualmente tem o mesmo texto do formato principal. Consulte os README de [Dunst](.config/dunst/README.md) e [Zen-Cal](.config/zen-cal/README.md).

Não há bloqueio automático, filtro noturno ou desligamento de tela por inatividade configurados por este conjunto. Hyprlock e Hyprsunset foram retirados; Hypridle está instalado, mas sem serviço ou regras ativos.

### Atalhos principais

`Super` é a tecla Windows. Consulte `modules/bindings.lua` e `modules/ecosystem.lua` para a lista completa.

| Atalho | Ação |
| --- | --- |
| `Super+Enter` | Alacritty/tmux |
| `Super+Espaço` | Hyprlauncher |
| `Super+Alt+E` | Emacs |
| `Super+Alt+X` | Xournal++ |
| `Super+H/J/K/L` | Mudar foco |
| `Super+1…0` | Trocar de workspace |
| `Print` | Capturar região |
| `Shift+Print` | Capturar janela |
| `Super+Print` | Capturar monitor |
| `Ctrl+Print` | Região somente para a área de transferência |
| `Super+Alt+P` | Selecionar e copiar cor |
| `Super+Alt+A` | Controle de áudio |
| `Super+Alt+I` | Informações do sistema |
| `Super+Ctrl+Esc` | Encerrar aplicativos e a sessão com Hyprshutdown |

Capturas salvas ficam em `~/Images/screenshots`.

## Git e push automático

Na instalação atual, `~/` é o repositório principal, na branch `main`. Os remotos `personal` e `origin` apontam para este projeto. O script `.local/bin/auto-push.sh`:

1. processa os submódulos recursivamente, dos filhos para o pai;
2. cria commits quando existem alterações nos arquivos permitidos pelo Git;
3. envia os submódulos antes de registrar e enviar suas referências no pai;
4. comunica falhas ao systemd e volta a tentar commits pendentes na próxima execução;
5. impede execuções simultâneas e não força push nem faz pull automático.

Se o remoto avançar ou divergir, integre o histórico manualmente antes de executar novamente. Submódulos em HEAD destacado ou com conflitos também interrompem o envio.

```sh
# Conferir os arquivos que seriam enviados, sem criar commits
~/.local/bin/auto-push.sh --dry-run

# Executar agora e consultar o resultado
systemctl --user start git-auto-push.service
journalctl --user -u git-auto-push.service -n 50

# Habilitar o agendamento em uma instalação já preparada
systemctl --user daemon-reload
systemctl --user enable --now git-auto-push.timer
systemctl --user list-timers git-auto-push.timer
```

O timer executa a cada hora, com atraso aleatório de até dois minutos e `Persistent=true`. O usuário tem linger habilitado para permitir execução após logout. A máquina precisa estar ligada, com rede e autenticação SSH disponíveis. As unidades exigem Bash, Python 3 com `Path.is_relative_to`, Git, OpenSSH e `flock`.

## Atualização manual e recuperação

Antes de alterar referências de submódulos, confira `git status` no pai e nos filhos. `git submodule update` pode deixar os filhos em HEAD destacado; use uma branch apropriada para editar e publicar.

Em uma árvore limpa, os comandos de atualização convencionais são:

```sh
git pull --ff-only
git submodule update --init --recursive
```

Para publicar manualmente, faça commit e push no submódulo primeiro; depois registre o novo gitlink no repositório principal. O script automático já respeita essa ordem.

A recuperação usa backups locais e o histórico Git. Não há desinstalador ou rollback completo do sistema: pacotes, wrappers e configurações em `/etc` têm manutenção separada.
