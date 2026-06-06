# ~/.bashrc

# Se não for interativo, não faz nada
case $- in
    *i*) ;;
    *) return;;
esac

# Configurações de Histórico
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Configurações de terminal
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Configuração de prompt colorido
if [ "$TERM" = "xterm-color" ] || [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Alias para ls, grep e cores
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Importa aliases externos se existirem
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Habilita completamento de comandos (se disponível)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Variáveis de ambiente (PATHs personalizados)
export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
export PATH="/usr/local/texlive/2026/texmf-dist/doc/info:$PATH"
export PATH="/usr/local/texlive/2026/texmf-dist/doc/man:$PATH"
export PATH="/home/joaob/.config/emacs/bin:$PATH"
export MANPATH="/home/joaob/.cache/yay/texlive-full/pkg/texlive-full/opt/texlive/2026/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/home/joaob/.cache/yay/texlive-full/pkg/texlive-full/opt/texlive/2026/texmf-dist/doc/info:$INFOPATH"
export PATH="/home/joaob/.cache/yay/texlive-full/pkg/texlive-full/opt/texlive/2026/bin/x86_64-linux:$PATH"
export BIBINPUTS="/home/joaob/Latex/References:"
