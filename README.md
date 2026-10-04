# Dotfiles — Arch Linux + Hyprland

Configurações pessoais para uma sessão **Arch Linux/Wayland com Hyprland**. Este repositório não contém um instalador, um manifesto de pacotes nem um mecanismo de *stow*/*symlinks*: a instalação é deliberadamente manual, por cópia dos arquivos escolhidos.

> **Estado verificado:** `main` em `c867d011a453ecf0887f542125a9f9848781de4d` (03/10/2026), incluindo os submódulos `doom` e `xournalpp`. As instruções abaixo foram conferidas contra esse checkout.

![Captura de tela originalmente associada ao projeto](https://i.imgur.com/0QaopZ4.png)


## Escopo e compatibilidade

- **Distribuição declarada:** Arch Linux (o README original diz “ArchLinux”). Os aliases usam `pacman` e `yay`; não há suporte declarado para outra distribuição.
- **Sessão gráfica:** Hyprland em Wayland, painel Waybar, terminal Alacritty e multiplexador tmux.
- **Shell:** Bash. Os arquivos de topo são `.bashrc`, `.bash_aliases` e `.vimrc`.
- **Editor:** Doom Emacs (submódulo) e Vim. Há configurações de LaTeX, Org, Python, Lean, Markdown, JSON, YAML, shell e web no Doom Emacs.
- **Outros aplicativos configurados:** Zathura, htop, yay, Gigolo e Xournal++ (submódulo).

Não há configuração de GNOME, KDE, i3, Sway, fish ou zsh neste checkout.

## Antes de começar

Faça a instalação em uma conta de usuário normal, **não** como root. Leia primeiro a seção [Ajustes obrigatórios desta máquina](#ajustes-obrigatórios-desta-máquina): várias configurações apontam para `/home/joaob`, dispositivos e discos específicos.

Ferramentas necessárias para obter os arquivos:

```bash
sudo pacman -S git
```

Para inicializar submódulos via SSH, as URLs atuais exigem acesso à chave SSH do GitHub:

```text
git@github.com:joaobertholino/doom.git
git@github.com:joaobertholino/xournalpp.git
```

Se a chave SSH não estiver disponível, o clone dos submódulos falhará. É possível clonar só o repositório principal sem `--recurse-submodules` e instalar os componentes que não dependem deles; Doom e Xournal++ ficarão ausentes.

## Dependências observadas

Como não existe uma lista de pacotes no repositório, a tabela lista somente programas, fontes e serviços **referenciados diretamente** pelos arquivos. A coluna “uso” não implica que todos sejam necessários para uma instalação parcial.

| Área | Programas/recursos referenciados | Uso observado |
| --- | --- | --- |
| Base gráfica | `hyprland`, `hyprctl`, `hyprpaper`, `waybar`, `dunst`, `hyprlauncher`, `nm-applet` | Sessão, papel de parede, painel, notificações, lançador e applet de rede |
| Terminal | `alacritty`, `tmux`, fonte **0xProto Nerd Font** | Alacritty abre `tmux new-session -A -s main`; a fonte é definida no `alacritty.toml` |
| Áudio e mídia | `wpctl`, `pactl`, `playerctl`, `notify-send` | Teclas multimídia e indicador/mute de microfone |
| Scripts Hyprland | `hyprshot`, `jq`, `sed`, `mkdir`, `date` | Captura de região e alternância de orientação |
| Aplicativos de atalhos | `emacs`, `qalculate-gtk`, `zen-browser`, `xournalpp` | Atalhos `Super+Alt+E/C/B/X` |
| Shell/aliases | `bat`, `fastfetch`, `trash-put`, `trash-list`, `trash-restore`, `trash-empty`, `btrfs-assistant`, `yay`, `vim` | Aliases em `.bash_aliases` |
| Doom Emacs/LaTeX | Doom Emacs, `aspell` com dicionário `pt_BR`, `latexmk`, LuaLaTeX, `texlab`, `pandoc` | Configurações em `.config/doom/config.el` |
| Documentos | `zathura`, fonte **Wigrum Regular** | Tema/configuração do Zathura |

Em Arch, diversos nomes de pacote podem ser confirmados no momento da instalação com `pacman -Si <nome>`. O repositório não informa de onde vêm `hyprlauncher`, `zen-browser`, a fonte 0xProto Nerd Font, Wigrum, o carregador Lua de Hyprland, Doom Emacs ou os pacotes do AUR; portanto, não há um comando de instalação confiável para esses itens neste README.

Para a base cuja instalação é verificável nos repositórios configurados desta máquina, uma instalação inicial possível é:

```bash
sudo pacman -S \
  hyprland hyprpaper waybar alacritty tmux dunst \
  pipewire wireplumber pipewire-pulse playerctl jq libnotify hyprshot \
  qalculate-gtk xournalpp zathura zathura-pdf-mupdf \
  htop bat fastfetch trash-cli btrfs-assistant vim emacs \
  aspell aspell-pt texlive-binextra texlab
```

Esse comando é uma conveniência para os binários listados, não um manifesto oficial do projeto. Instale `pandoc`, `hyprlauncher`, `zen-browser`, as fontes e Doom Emacs pelo método compatível com a sua instalação depois de verificar a origem e o nome do pacote. `yay` é apenas configurado; o repositório não o instala.

## Instalação recomendada (seletiva e reversível)

1. Clone fora de `~` e traga os submódulos:

   ```bash
   mkdir -p "$HOME/src"
   git clone --recurse-submodules https://github.com/joaobertholino/dotfiles.git "$HOME/src/dotfiles"
   cd "$HOME/src/dotfiles"
   ```

2. Audite e adapte os valores pessoais antes de copiar qualquer coisa:

   ```bash
   rg -n '/home/joaob|HDMI-A-1|1920x1080@120|wacom-one-by-wacom-s-pen|/mnt/WDC-128|disk="sd[ab]"' \
     .bashrc .bash_aliases .config
   ```

3. Faça uma cópia de segurança dos destinos que o repositório realmente fornece. Guarde o caminho mostrado pelo último comando: ele é o ponto de rollback.

   ```bash
   backup_dir="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
   mkdir -p "$backup_dir/.config"
   for path in .bashrc .bash_aliases .vimrc \
     .config/alacritty .config/doom .config/gigolo .config/htop \
     .config/hypr .config/ly-dur .config/tmux .config/waybar \
     .config/xournalpp .config/yay .config/zathura; do
     if [ -e "$HOME/$path" ]; then
       mkdir -p "$backup_dir/$(dirname "$path")"
       cp -a "$HOME/$path" "$backup_dir/$path"
     fi
   done
   printf 'Backup: %s\n' "$backup_dir"
   ```

4. Copie primeiro uma área pequena e teste-a. Por exemplo, Alacritty + tmux:

   ```bash
   install -d "$HOME/.config"
   cp -a .config/alacritty .config/tmux "$HOME/.config/"
   ```

5. Quando os ajustes específicos estiverem feitos, instale os demais componentes desejados:

   ```bash
   cp -a .bashrc .bash_aliases .vimrc "$HOME/"
   cp -a .config/doom .config/gigolo .config/htop .config/hypr \
     .config/ly-dur .config/waybar .config/xournalpp .config/yay .config/zathura \
     "$HOME/.config/"
   ```

6. Abra uma nova sessão Bash para carregar os aliases e valide cada aplicativo. Para Doom Emacs, depois de instalar o framework Doom compatível, execute o binário `doom sync` disponibilizado por essa instalação. O repositório não contém o instalador do framework Doom.

Os comandos usam `cp -a`: substituem arquivos de mesmo nome nos componentes selecionados, mas não removem arquivos extras já existentes. Não use o antigo comando `cp -r temp_dots/. ~`: ele também copiaria o diretório `.git` para a home e não cria um backup.

## Instalação manual por componente

Prefira instalar somente o que pretende usar:

| Componente | Origem no repositório | Destino |
| --- | --- | --- |
| Bash e Vim | `.bashrc`, `.bash_aliases`, `.vimrc` | `~/` |
| Terminal | `.config/alacritty`, `.config/tmux` | `~/.config/` |
| Hyprland | `.config/hypr`, `.config/waybar`, `.config/ly-dur` | `~/.config/` |
| Emacs | `.config/doom` (submódulo) | `~/.config/doom` |
| Anotações | `.config/xournalpp` (submódulo) | `~/.config/xournalpp` |
| Aplicativos | `.config/zathura`, `.config/htop`, `.config/gigolo`, `.config/yay` | `~/.config/` |

Exemplo para um único componente:

```bash
cp -a "$HOME/src/dotfiles/.config/zathura" "$HOME/.config/"
```

## Ajustes obrigatórios desta máquina

Estes valores não são portáteis e devem ser editados ou removidos antes de habilitar o respectivo componente:

- **Usuário `joaob`:** caminhos absolutos em `.bashrc`, `.bash_aliases`, `.config/hypr/hyprland.lua`, scripts Hyprland, `hyprpaper.conf` e Waybar. O `package.path` do Hyprland e as chamadas de scripts deixam de funcionar em outra home.
- **Monitor/tablet:** `HDMI-A-1`, `1920x1080@120`, HDR, o tablet `wacom-one-by-wacom-s-pen` e o modo canhoto estão fixos nos módulos Hyprland.
- **Armazenamento:** Waybar consulta `/mnt/WDC-128`, `sda` e `sdb`.
- **Arquivos pessoais:** `.bashrc` aponta para uma instalação local de TeX Live 2026, cache do yay, `~/Latex/References` e `~/.tmp`. Doom aponta para `~/Org-Notes/`, `~/Projects/` e `~/Documents/{refs.bib,papers,notes}`.
- **Papel de parede:** `hyprpaper.conf` espera `/home/joaob/Images/wallpapers/black-wall.png`; esse arquivo não está versionado. Há alternativas versionadas em `.config/hypr/wallpaper-oled.png` e `.config/hypr/wallpaper.svg`.
- **Carregador Lua:** o arquivo de entrada é `hyprland.lua` e usa a API global `hl`, mas o checkout não inclui a implementação nem informa como o Hyprland carrega esse arquivo. Não há `hyprland.conf` tradicional. Descubra/instale o carregador Lua compatível antes de apontar a sessão para essa configuração.

## Atualização, remoção e rollback

Não existe script de atualização, desinstalação ou rollback. Atualize o checkout e reaplique somente os componentes que desejar:

```bash
git -C "$HOME/src/dotfiles" pull --ff-only
git -C "$HOME/src/dotfiles" submodule update --init --recursive
```

Compare antes de copiar:

```bash
diff -ruN "$HOME/.config/waybar" "$HOME/src/dotfiles/.config/waybar"
```

Para rollback, restaure o backup criado na instalação. O comando abaixo restaura seu conteúdo; revise conflitos e arquivos criados posteriormente antes de executá-lo:

```bash
cp -a "$backup_dir"/. "$HOME/"
```

Não há um comando de desinstalação seguro fornecido pelo projeto, porque a cópia mescla diretórios com a home. Remova manualmente apenas os componentes que você instalou e, de preferência, restaure o backup em seguida.

## Solução de problemas

- **Submódulo falhou:** confirme acesso SSH ao GitHub ou clone sem `--recurse-submodules`; os únicos submódulos são Doom e Xournal++.
- **Alacritty não abre:** ele chama `/usr/bin/tmux`; instale tmux ou altere `shell` em `.config/alacritty/alacritty.toml`. Instale também a 0xProto Nerd Font ou ajuste a família de fonte.
- **Hyprland não carrega ou `hl` não existe:** a camada que fornece a API Lua não é versionada. Não há como inferir um pacote ou comando de instalação confiável a partir deste repositório; mantenha uma configuração Hyprland funcional separada até resolver isso.
- **Waybar mostra discos errados ou scripts não executam:** corrija `/home/joaob`, `/mnt/WDC-128`, `sda` e `sdb` nos arquivos de Waybar.
- **Atalho de captura não funciona:** instale `hyprshot`; o script grava em `~/Images/screenshots` após adaptar o caminho absoluto.
- **Doom/LaTeX falha:** instale Doom Emacs e execute `doom sync`; depois instale os programas explicitamente usados (`aspell` com `pt_BR`, `latexmk`/LuaLaTeX, `texlab` e `pandoc`) conforme sua distribuição.
- **Fontes diferentes:** instale 0xProto Nerd Font para Alacritty e Wigrum para Zathura, ou escolha fontes presentes no sistema.

## Estrutura do repositório

```text
.
├── .bashrc / .bash_aliases / .vimrc
├── .config/
│   ├── alacritty/    # terminal; inicia tmux
│   ├── doom/         # submódulo: configuração Doom Emacs
│   ├── hypr/         # entrada Lua, módulos, scripts e papéis de parede
│   ├── tmux/         # prefixo C-a e layout de panes
│   ├── waybar/       # painel e scripts de métricas/áudio
│   ├── xournalpp/    # submódulo: preferências e modelos
│   └── gigolo/ htop/ ly-dur/ yay/ zathura/
├── .gitmodules
└── README.md
```

## Atalhos principais do Hyprland

Com `Super` como modificador: `Super+Enter` abre Alacritty, `Super+Space` abre `hyprlauncher`, `Super+W` fecha a janela, `Super+M` alterna tela cheia, `Super+H/J/K/L` muda o foco e `Super+1…0` troca de espaço de trabalho. `Print` chama o script de captura e as teclas de mídia controlam PipeWire/Playerctl. Consulte `.config/hypr/modules/bindings.lua` para a lista completa.
