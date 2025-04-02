#!/bin/bash

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE=ls:history:pwd
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

[ -f /etc/bash_completion ] && . /etc/bash_completion

[ -f ~/.cargo/env ] && . ~/.cargo/env

[ -f ~/.fzf.bash ] && . ~/.fzf.bash

eval "$(gh completion -s bash)"

[ -f ~/.bashrc.local ] && . ~/.bashrc.local


export FZF_DEFAULT_OPTS="--height=70%"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

############### ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
