alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias cat='bat'
alias sysfetch='fastfetch'

alias docker-rm-all='sudo docker rm -f $(sudo docker ps -aq)'
alias docker-rmi-all='sudo docker rmi -f $(sudo docker image -aq)'
alias docker-stop-all='sudo docker stop $(sudo docker ps -q)'
