#! /bin/bash

set -e

cd $(dirname ${BASH_SOURCE:-$0})

# Setup bash completion for tmux
mkdir -p ~/.bash_completion.d
curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" > ~/.bash_completion.d/tmux

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# TODO: fzf, cargo, eza, bat, gh, fd, tmux, dotman, uv, HackGen NF, alacritty 
