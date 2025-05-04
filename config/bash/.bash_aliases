#!/bin/bash

alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

alias cd..='cd ..'
alias cd~='cd ~'
alias cd-='cd -'

alias cdi='__zoxide_zi'
alias cdg='cd `git rev-parse --show-toplevel`'

alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'

alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

alias mkdir='mkdir -p'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias sl='ls'

alias bat='bat --color=always'

alias tree='eza -T'

alias grep='grep --color=auto'

alias path='echo -e ${PATH//:/\\n}'

alias va='source .venv/bin/activate'
alias bashrc='source ~/.bashrc'

alias untar='tar -xvf'
alias untargz='tar -zxvf'

alias uvr='uv run'
alias uvt='uv run task'

alias cls='clear'

alias nsmi='nvidia-smi'
alias csmi='cluster-smi'

alias nowdate=$'date +\'%Y-%m-%d\''
alias nowtime=$'date +\'%T\''
alias now=$'date +\'%Y-%m-%d %T\''

alias whi='which'
complete -c whi

alias tm='tmux'
complete -F _tmux tm

alias fzf-tmux='fzf-tmux ${FZF_TMUX_OPTS}'
alias fts='fzf-tmux-switcher'
alias ftss='fzf-tmux-switcher-ssh'

alias fg='fzf-git'
alias fgs='fzf-git stash'
alias fgb='fzf-git branch'

alias shutdown='sudo shutdown -h now'

alias bell=$'echo -e \'\a\''
