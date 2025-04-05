#!/bin/bash

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE=ls:history:pwd
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; }
pupdate ~/.local/bin
unset -f pupdate

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
CURRENT_TIME=' \[\033[00;33m\]\t\[\033[00m\]'
USERNAME=' \[\033[01;32m\]\u\[\033[00m\]'
HOSTNAME_IF_SSH='\[\033[01;32m\]$(if [ -n "$SSH_CONNECTION" ]; then echo "@\h"; fi)\[\033[00m\]'
CURRENT_DIR='\[\033[01;36m\]\w\[\033[00m\]'
GIT_BRANCH=' $(__git_ps1 "(git:%s)")'
PYTHON_INFO=' $(if [ "${VIRTUAL_ENV:+x}" ] && command -v python &>/dev/null; then ENV_NAME="${VIRTUAL_ENV_PROMPT//[()]/}"; [ -z "$ENV_NAME" ] && ENV_NAME="$(basename "$VIRTUAL_ENV")"; echo "(py:$ENV_NAME@$(python -V |& cut -d " " -f2))"; fi)'

PS1="${LAST_COMMAND_STATUS}${CURRENT_TIME}${USERNAME}${HOSTNAME_IF_SSH}:${CURRENT_DIR}${GIT_BRANCH}${PYTHON_INFO}\n$ "

export FZF_DEFAULT_OPTS='--exit-0 --height 70% --reverse --ansi --bind "ctrl-s:preview-half-page-down,ctrl-w:preview-half-page-up,ctrl-\/:change-preview-window(80%|hidden|)" --preview-border line --preview-window wrap'
export FZF_CTRL_R_OPTS='--preview "echo {} | bat --color=always --language=sh --style=plain"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=plain {}"'
export FZF_ALT_C_OPTS='--preview "tree -L 2 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --color always'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --color always'

export VIRTUAL_ENV_DISABLE_PROMPT=1
