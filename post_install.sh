#!/bin/bash

# this file executes once the configs are applied
# this is useful for chmod +x on scripts for example

set -e

mkdir -p $HOME/.config/zsh
[[ -e $HOME/.config/zsh/zsh-autocomplete ]] || \
    git clone https://github.com/marlonrichert/zsh-autocomplete $HOME/.config/zsh/zsh-autocomplete
[[ -e $HOME/.config/zsh/zsh-autosuggestions ]] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/zsh-autosuggestions
[[ -e $HOME/.config/zsh/zsh-system-clipboard ]] || \
    git clone https://github.com/kutsan/zsh-system-clipboard $HOME/.config/zsh/zsh-system-clipboard
[[ -e $HOME/.config/zsh/zsh-syntax-highlighting ]] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/zsh-syntax-highlighting

cd tmux-status
g++ -std=c++2a -o tmux-status -I include src/*
[[ ! -e ~/.bin ]] && mkdir ~/.bin
[[ ! -d ~/.bin ]] && echo "~/.bin is not a directory" && exit 1
cp tmux-status ~/.bin
cd ..

