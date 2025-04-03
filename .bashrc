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

LAST_COMMAND_STATUS='$(if [ $? -eq 0 ]; then echo "\033[01;32m\](o_o)b"; else echo "\033[01;31m\](x_x;)"; fi)\[\033[00m\]'
CURRENT_TIME='\[\033[00;33m\]\t\[\033[00m\]'
USERNAME='\[\033[01;32m\]\u\[\033[00m\]'
HOSTNAME_IF_SSH='\[\033[01;32m\]$(if [ -n "$SSH_CONNECTION" ]; then echo "@\h"; fi)\[\033[00m\]'
CURRENT_DIR='\[\033[01;36m\]\w\[\033[00m\]'
GIT_BRANCH='$(__git_ps1 "(git:%s)")'
if [ $VIRTUAL_ENV ] && [ $(command -v python) ]; then
   if [ -n "$VIRTUAL_ENV_PROMPT" ]; then
      ENV_NAME="${VIRTUAL_ENV_PROMPT//[()]/}"
   else
      ENV_NAME=$(basename "$VIRTUAL_ENV")
   fi
   PYTHON_INFO="(py:$(python -V |& cut -d ' ' -f2-1)@$ENV_NAME)"
else
   PYTHON_INFO=''
fi

PS1="${LAST_COMMAND_STATUS} ${CURRENT_TIME} ${USERNAME}${HOSTNAME_IF_SSH}:${CURRENT_DIR} ${GIT_BRANCH} ${PYTHON_INFO}\n$ "

export FZF_DEFAULT_OPTS='--height=70%'

export VIRTUAL_ENV_DISABLE_PROMPT=1
