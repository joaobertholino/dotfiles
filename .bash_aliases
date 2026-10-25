# System
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias cat='bat'
alias sysf='fastfetch -c all-personal.jsonc --logo none'
alias cls='clear'
alias clsh='cd && clear'
alias rmpkg='sudo rm -rfv /var/cache/pacman/pkg/* && sudo rm -rfv /home/joaob/.cache/yay/*'
alias tshp='trash-put -rvf'
alias tshl='trash-list'
alias tshr='trash-restore'
alias tshe='trash-empty'
alias pwoff='systemctl poweroff'
alias rebootsys='systemctl reboot'
alias logout='loginctl terminate-user $(whoami)'
alias suspend='systemctl suspend'
alias yaya='yay --noconfirm'
alias btral='btrfs-assistant-launcher'

#SSH
alias ssh-ime='ssh linux-ime'

# Git
alias ginit='git init'
alias gbranch='git branch'
alias gcheckb='git checkout'
alias gdelb='git branch -d'
alias gdelbf='git branch -D'
alias gadda='git add .'
alias gadd='git add'
alias gcommit='git commit -m'
alias gpush='git push'
alias gpusho='git push origin'
alias gpushom='git push origin main'
alias greseth='git reset --hard'
alias gresets='git reset --soft'
alias gremotev='git remote -v'
alias gremotea='git remote add'
alias gremoteao='git remote add origin'
alias gremoterm='git remote remove'
alias gmremotermo='git remote remove origin'
alias glog='git log'
alias gstat='git status'
alias gpusham='git add . && git commit -m "." && git push origin main'
alias gpushfa='git submodule foreach "git push origin main"'
alias grmcache='git rm -fr --cached ./'

# Alacritty and Tmux
alias exit-at='tmux kill-session -t main && exit'

# Vim
alias vimf='vim +'

# Gentoo: atalhos do Portage
alias ei='sudo emerge --ask'
alias eu='sudo emerge --ask --update --deep --newuse @world'
alias es='emerge --search'
alias ep='emerge --pretend --verbose'
alias esync='sudo emaint sync -a'
alias ebin='sudo emerge --ask --getbinpkg --usepkgonly --with-bdeps=n'
alias esrc='sudo emerge --ask --usepkg=n --getbinpkg=n'
alias edepclean='sudo emerge --ask --depclean'
alias erebuild='sudo emerge --ask @preserved-rebuild'
alias enews='sudo eselect news read'

# Nix: perfil de aplicativos e binários pré-compilados.
# Exemplo: ni nixpkgs#hello ; ns firefox ; nr hello
alias ni='sudo nix profile add --profile /opt/nix-profile --max-jobs 0'
alias ns='sudo nix search nixpkgs'
alias nl='sudo nix profile list --profile /opt/nix-profile'
alias nu='sudo nix profile upgrade --profile /opt/nix-profile --max-jobs 0 --all'
alias nr='sudo nix profile remove --profile /opt/nix-profile'
alias nh='sudo nix profile history --profile /opt/nix-profile'
alias nrollback='sudo nix profile rollback --profile /opt/nix-profile'
alias ngc='sudo nix store gc'

case ":$PATH:" in
    *:/opt/nix-profile/bin:*) ;;
    *) export PATH="/opt/nix-profile/bin:$PATH" ;;
esac
case ":${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:" in
    *:/opt/nix-profile/share:*) ;;
    *) export XDG_DATA_DIRS="/opt/nix-profile/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}" ;;
esac
