#! /bin/bash

cd $(dirname ${BASH_SOURCE:-$0})

# Setup bash completion for tmux
mkdir -p ~/.bash_completion.d
curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" > ~/.bash_completion.d/tmux

# TODO: fzf, cargo, eza, bat, gh, fd, tmux, dotman, uv, HackGen NF, alacritty 
