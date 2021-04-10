#!/bin/bash

[[ -z $XDG_DATA_HOME ]]   && XDG_DATA_HOME=$HOME/.local/share
[[ -z $XDG_CACHE_HOME ]]  && XDG_CACHE_HOME=$HOME/.cache
[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config

[[ ! -e $XDG_DATA_HOME ]]   && mkdir -p $XDG_DATA_HOME
[[ ! -e $XDG_CACHE_HOME ]]  && mkdir -p $XDG_CACHE_HOME
[[ ! -e $XDG_CONFIG_HOME ]] && mkdir -p $XDG_CONFIG_HOME

[[ ! -e $XDG_CONFIG_HOME/zsh ]] && mkdir -p $XDG_CONFIG_HOME/zsh
[[ ! -e $XDG_CONFIG_HOME/vim ]] && mkdir -p $XDG_CONFIG_HOME/vim

DOTFILE_HOME=$(cd $(dirname $0); pwd)

ln -nfs $DOTFILE_HOME/.config/zsh/user $XDG_CONFIG_HOME/zsh/user
ln -nfs $DOTFILE_HOME/.config/vim/user $XDG_CONFIG_HOME/vim/user
ln -nfs $DOTFILE_HOME/.zshrc $HOME/.zshrc
ln -nfs $DOTFILE_HOME/.vimrc $HOME/.vimrc
ln -nfs $DOTFILE_HOME/.tmux.conf $HOME/.tmux.conf
ln -nfs $DOTFILE_HOME/.gitignore_global $HOME/.gitignore_global
if [[ ! "${1:-}" == "--ignore-gitconfig" ]]; then
  cp $DOTFILE_HOME/.gitconfig $HOME/.gitconfig
fi

if [[ ! -e $XDG_DATA_HOME/zsh/powerlevel9k ]]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $XDG_DATA_HOME/zsh/powerlevel9k
fi
if [[ ! -e $XDG_DATA_HOME/zsh/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $XDG_DATA_HOME/zsh/zsh-syntax-highlighting
fi
if [[ ! -e $XDG_DATA_HOME/tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm $XDG_DATA_HOME/tmux/plugins/tpm
fi
if [[ ! -e $XDG_DATA_HOME/anyenv ]]; then
  git clone https://github.com/anyenv/anyenv.git $XDG_DATA_HOME/anyenv
fi

echo "source $HOME/.zshrc"
