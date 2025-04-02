#!/bin/bash

set -e

cd "$(dirname "${BASH_SOURCE:-$0}")"

# Setup bash completion for tmux
mkdir -p ~/.bash_completion.d
curl -fSsL https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux > ~/.bash_completion.d/tmux

curl -fSsL https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh > ~/.bash-preexec.sh

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Dependencies Check
not_installed_list=()
for cmd in fzf cargo eza bat gh fd tmux uv git zoxide rg; do
   if ! command -v ${cmd} &> /dev/null; then
      not_installed_list+=("${cmd}")
   fi
done
if [[ ${#not_installed_list[@]} == 0 ]]; then
   echo "All dependencies are installed."
else
   echo "The following dependencies are not installed: ${not_installed_list[*]}"
fi

# TODO: fzf, cargo, eza, bat, gh, fd, tmux, dotman, uv, HackGen NF, zoxide, rg
