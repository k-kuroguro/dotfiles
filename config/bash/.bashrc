#!/bin/bash

# If not running interactively, don't do anything.
[[ $- == *i* ]] || return

DOTFILES_DIR="$(dirname "$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE:-$0}")")")")"
export DOTFILES_DIR

HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE=ls:history:pwd
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s checkwinsize

pupdate() { case ":${PATH:=$1}:" in *:"$1":*) ;; *) PATH="$1:$PATH" ;; esac; } # Add to PATH if not already there.
pupdate ~/.local/bin
pupdate ~/bin
pupdate "${DOTFILES_DIR}/bin"
pupdate "${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin"
unset -f pupdate

export AQUA_GLOBAL_CONFIG=~/.config/aqua/aqua.yaml # Must be set before running any aqua-installed commands
export AQUA_REMOVE_MODE=pl
export AQUA_DISABLE_LAZY_INSTALL=true
export AQUA_PROGRESS_BAR=true

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

[[ -f /etc/bash_completion ]] && . /etc/bash_completion
if [[ -d ~/.bash_completion.d ]]; then
   for f in ~/.bash_completion.d/*; do
      [[ -f "$f" ]] && . "$f"
   done
fi

[[ -f ~/.cargo/env ]] && . ~/.cargo/env

[[ -f ~/.deno/env ]] && . ~/.deno/env

command -v gh &>/dev/null && eval "$(gh completion -s bash)"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion bash)"
command -v zoxide &>/dev/null && eval "$(zoxide init bash --no-cmd)"
command -v rg &>/dev/null && eval "$(rg --generate complete-bash)"
command -v deno &>/dev/null && eval "$(deno completions bash)"
command -v aqua &> /dev/null && eval "$(aqua completion bash)"
command -v fzf &>/dev/null && eval "$(fzf --bash)"

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_STATESEPARATOR=

LAST_COMMAND_STATUS='$(if [ $? -eq 0 ]; then echo "\033[01;32m\](o_o)b"; else echo "\033[01;31m\](x_x;)"; fi)\[\033[00m\]'
CURRENT_TIME=' \[\033[00;33m\]\t\[\033[00m\]'
USERNAME=' \[\033[01;32m\]\u\[\033[00m\]'
HOSTNAME_IF_SSH='\[\033[01;32m\]$(if [ -n "${SSH_CONNECTION:-}" ]; then echo "@\h"; fi)\[\033[00m\]'
CURRENT_DIR='\[\033[01;36m\]\w\[\033[00m\]'
GIT_BRANCH='$(command -v __git_ps1 &>/dev/null && __git_ps1 " (git:%s)" || :)'
PYTHON_INFO='$(if [ "${VIRTUAL_ENV:+x}" ] && command -v python &>/dev/null; then ENV_NAME="$(echo ${VIRTUAL_ENV_PROMPT//[()]/} | xargs)"; [ -z "$ENV_NAME" ] && ENV_NAME="$(basename "$VIRTUAL_ENV")"; echo " (python:$ENV_NAME@$(python -V |& cut -d " " -f2))"; fi)'
RUST_VERSION='$(if [ -f "Cargo.toml" ] && command -v rustc &>/dev/null; then echo " (rustc:$(rustc -V | cut -d " " -f2))"; fi)'

PS1="${LAST_COMMAND_STATUS}${CURRENT_TIME}${USERNAME}${HOSTNAME_IF_SSH}:${CURRENT_DIR}${GIT_BRANCH}${PYTHON_INFO}${RUST_VERSION}\n$ "
# (o_o)b 12:34:56 username@hostname:/path/to/dir (git:main*) (python:venv@3.8.10) (rustc:1.54.0)
# $

export FZF_DEFAULT_OPTS=$'--height 70% --reverse --ansi --bind \'ctrl-s:preview-half-page-down,ctrl-w:preview-half-page-up,ctrl-/:change-preview-window(80%|hidden|)\' --preview-border line --preview-window 50%,wrap'
export FZF_CTRL_R_OPTS=$'--preview \'echo {} | bat --color=always --language=sh --style=plain\''
export FZF_CTRL_T_OPTS=$'--preview \'bat --color=always --style=plain {}\''
export FZF_ALT_C_OPTS=$'--preview \'eza -T -L=2 --color=always {}\''
export FZF_DEFAULT_COMMAND='fd --type f --hidden --color always'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND='fd --type d --hidden --color always'
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p 80%'

_fzf_compgen_path() {
   fd --hidden --color always . "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --color always . "$1"
}

_fzf_comprun() {
   local command="$1"
   shift

   case "$command" in
      cd) fzf --preview 'eza -T -L=2 --color=always {}' "$@" ;;
      export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
      *) fzf "$@" ;;
   esac
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

export _ZO_FZF_OPTS="${FZF_DEFAULT_OPTS}"" --preview \"echo {} | awk '{print \$2}' | xargs eza -T -L=2 --color=always\""
if command -v __zoxide_zi >/dev/null 2>&1; then
   cd() {
      if [[ $# == 0 ]]; then
         __zoxide_zi
      else
         \builtin cd -- "$@"
      fi
   }
fi

bind -x '"\C-f":fzf-tmux-switcher-ssh'

export CMD_END_BELL_SECS=180 # Ring a bell if a command runs for more than CMD_END_BELL_SECS seconds.

__command_timer_preexec() {
   __timer_start=$(date +%s)
}

__command_timer_precmd() {
   if [[ -n $__timer_start ]]; then
      if (( $(date +%s) - __timer_start > CMD_END_BELL_SECS )); then
         echo -e '\a'
      fi

      unset __timer_start
   fi
}

preexec_functions+=(__command_timer_preexec)
precmd_functions+=(__command_timer_precmd)

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local

[[ -f ~/.bash-preexec.sh ]] && . ~/.bash-preexec.sh

:
