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

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_STATESEPARATOR=

PS1='$(if [ $? -eq 0 ]; then echo "\033[01;32m\](^_^)"; else echo "\033[01;31m\](>_<)"; fi)\[\033[00m\] \[\033[00;33m\]\t\[\033[00m\] \[\033[01;32m\]\u$(if [ -n "$SSH_CONNECTION" ]; then echo "@\h"; fi)\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\] $(__git_ps1 "(%s)")\n\$ '

export FZF_DEFAULT_OPTS="--height=70%"
