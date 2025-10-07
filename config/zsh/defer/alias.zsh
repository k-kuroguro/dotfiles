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

alias zshenv='source ~/.zshenv'
alias zshrc='source ${ZDOTDIR}/.zshrc'

alias uvr='uv run'
alias uvt='uv run task'

alias cls='clear'

alias nsmi='nvidia-smi'
alias csmi='cluster-smi'

alias nowdate=$'date +\'%Y-%m-%d\''
alias nowtime=$'date +\'%T\''
alias now=$'date +\'%Y-%m-%d %T\''

alias tm='tmux'

alias fzf-tmux='fzf-tmux ${FZF_TMUX_OPTS}'
alias fts='fzf-tmux-switcher'
alias ftss='fzf-tmux-switcher-ssh'

alias fg='fzf-git'
alias fgs='fzf-git stash'
alias fgb='fzf-git branch'

alias shutdown='sudo shutdown -h now'

alias bell=$'echo -e \'\a\''
alias serve='miniserve'

alias btm='btm -b'
alias top='btm'
alias htop='btm'

alias -s py='uv run'
alias -s json='fx'

function extract() {
   case $1 in
      *.tar.gz|*.tgz) tar xzvf "$1" ;;
      *.tar.xz) tar Jxvf "$1" ;;
      *.zip) unzip "$1" ;;
      *.lzh) lha e "$1" ;;
      *.tar.bz2|*.tbz) tar xjvf "$1" ;;
      *.tar.Z) tar zxvf "$1" ;;
      *.gz) gzip -d "$1" ;;
      *.bz2) bzip2 -dc "$1" ;;
      *.Z) uncompress "$1" ;;
      *.tar) tar xvf "$1" ;;
      *.arj) unarj "$1" ;;
      *) echo "unknown format: $1" ;;
   esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
