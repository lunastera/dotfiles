#!/bin/bash

[[ -z $XDG_DATA_HOME ]]   && XDG_DATA_HOME=$HOME/.local/share
[[ -z $XDG_CACHE_HOME ]]  && XDG_CACHE_HOME=$HOME/.cache
[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config

[[ ! -e $XDG_DATA_HOME ]]   && mkdir -p $XDG_DATA_HOME
[[ ! -e $XDG_CACHE_HOME ]]  && mkdir -p $XDG_CACHE_HOME
[[ ! -e $XDG_CONFIG_HOME ]] && mkdir -p $XDG_CONFIG_HOME

mkdir $XDG_CONFIG_HOME/vim
mkdir $XDG_CONFIG_HOME/zsh
ln -s $HOME/dotfiles/.config/vim/user $XDG_CONFIG_HOME/vim/user
ln -s $HOME/dotfiles/.config/zsh/user $XDG_CONFIG_HOME/zsh/user
ln -s $HOME/dotfiles/.hyper.js $HOME/.hyper.js
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig

# ohmyzsh install
git clone https://github.com/ohmyzsh/ohmyzsh.git $XDG_DATA_HOME/ohmyzsh
git clone https://github.com/bhilburn/powerlevel9k.git $XDG_CONFIG_HOME/ohmyzsh/custom/themes/powerlevel9k

# tpm install
git clone https://github.com/tmux-plugins/tpm $XDG_DATA_HOME/tmux/plugins/tpm

# anyenv install
git clone https://github.com/anyenv/anyenv.git $XDG_DATA_HOME

source $HOME/.zshrc
