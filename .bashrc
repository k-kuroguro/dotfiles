#!/bin/bash

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE=ls:history:pwd
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ]; then
   . /etc/bash_completion
fi

if [ -f ~/.cargo/env ]; then
   . ~/.cargo/env
fi

if [ -f ~/.fzf.bash ]; then
   . ~/.fzf.bash
fi

eval "$(gh completion -s bash)"

if [ -f ~/.bashrc.local ]; then
   . ~/.bashrc.local
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
