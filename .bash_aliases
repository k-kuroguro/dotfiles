alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias cd..='cd ..'
alias cd~='cd ~'

alias g='git'

alias mkdir='mkdir -p'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias sl='ls'

alias tree='eza -T'

alias grep='grep --color=auto'

alias va='source .venv/bin/activate'
alias bashrc='source ~/.bashrc'

alias untar='tar -xvf'
alias untargz='tar -zxvf'

alias uvt='uv run task'

alias cls='clear'

alias nsmi='nvidia-smi'
alias csmi='cluster-smi'

if command -v __git_complete &>/dev/null; then
   __git_complete g __git_main
fi
