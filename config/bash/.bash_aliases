#!/usr/bin/env bash

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ~='cd ~'
alias -- -='cd ${OLDPWD}'

alias cd..='cd ..'
alias cd~='cd ~'
alias cd-='cd ${OLDPWD}'

alias cdi='__zoxide_zi'
alias cdg='cd `git rev-parse --show-toplevel`'

alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gst='git status'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gbr='git branch'
alias gd='git diff'

alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'

alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

alias mkdir='mkdir -p'

alias eza='eza --group-directories-first --classify=always --color=auto'
alias ls='eza'
alias ll='eza -alF --icons=auto'
alias la='eza -a'
alias sl='ls'

alias tree='eza -T'

alias bat='bat --color=always'

alias grep='grep --color=auto'

alias path='echo -e ${PATH//:/\\n}'

alias va='source .venv/bin/activate'

alias bashrc='source ~/.bashrc'

alias uvr='uv run'
alias uvt='uv run task'

alias debugpy='uvx debugpy --wait-for-client --listen 5678'

alias cls='clear'

alias nsmi='nvidia-smi'
alias csmi='cluster-smi'

alias nowdate=$'date +\'%Y-%m-%d\''
alias nowtime=$'date +\'%T\''
alias now=$'date +\'%Y-%m-%d %T\''

alias shutdown='sudo shutdown -h now'

alias bell=$'echo -e \'\a\''

alias serve='miniserve'
complete -F _miniserve serve

alias btm='btm -b'
alias top='btm'
alias htop='btm'

alias lg='lazygit'

alias j='just'
alias jg='just -g'
complete -F _just -o bashdefault -o default j
complete -F _just -o bashdefault -o default jg
