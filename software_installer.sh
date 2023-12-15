#!/bin/bash

pacman -S emacs exa wofi zsh ttf-iosevka-nerd --noconfirm

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

rm -rf .oh-my-zsh/custom/themes/powerlevel10k/.git
