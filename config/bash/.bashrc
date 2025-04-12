#!/bin/bash

# If not running interactively, don't do anything.
[[ $- == *i* ]] || return

export DOTFILES_DIR=$(dirname "$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE:-$0}")")")")

HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE=ls:history:pwd
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; } # Add to PATH if not already there.
pupdate ~/.local/bin
pupdate $DOTFILES_DIR/bin
unset -f pupdate

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

[ -f /etc/bash_completion ] && . /etc/bash_completion
[ -f ~/.bash_completion.d/alacritty ] && . ~/.bash_completion.d/alacritty
[ -f ~/.bash_completion.d/tmux ] && . ~/.bash_completion.d/tmux

[ -f ~/.cargo/env ] && . ~/.cargo/env

[ -f ~/.fzf.bash ] && . ~/.fzf.bash

command -v gh &>/dev/null && eval "$(gh completion -s bash)"
command -v dotman &>/dev/null && eval "$(dotman completion -s bash)"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion bash)"

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
GIT_BRANCH='$(__git_ps1 " (git:%s)")'
PYTHON_INFO='$(if [ "${VIRTUAL_ENV:+x}" ] && command -v python &>/dev/null; then ENV_NAME="$(echo ${VIRTUAL_ENV_PROMPT//[()]/} | xargs)"; [ -z "$ENV_NAME" ] && ENV_NAME="$(basename "$VIRTUAL_ENV")"; echo " (python:$ENV_NAME@$(python -V |& cut -d " " -f2))"; fi)'
RUST_VERSION='$(if [ -f "Cargo.toml" ] && command -v rustc &>/dev/null; then echo " (rustc:$(rustc -V | cut -d " " -f2))"; fi)'

PS1="${LAST_COMMAND_STATUS}${CURRENT_TIME}${USERNAME}${HOSTNAME_IF_SSH}:${CURRENT_DIR}${GIT_BRANCH}${PYTHON_INFO}${RUST_VERSION}\n$ "
## (o_o)b 12:34:56 username@hostname:/path/to/dir (git:main*) (python:venv@3.8.10) (rustc:1.54.0)
## $

export FZF_DEFAULT_OPTS='--exit-0 --height 70% --reverse --ansi --bind "ctrl-s:preview-half-page-down,ctrl-w:preview-half-page-up,ctrl-\/:change-preview-window(80%|hidden|)" --preview-border line --preview-window wrap'
export FZF_CTRL_R_OPTS='--preview "echo {} | bat --color=always --language=sh --style=plain"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=plain {}"'
export FZF_ALT_C_OPTS='--preview "eza -T -L=2 --color=always {}"'
export FZF_DEFAULT_COMMAND='fd --type f --color always'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --color always'
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

export VIRTUAL_ENV_DISABLE_PROMPT=1
