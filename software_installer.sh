#!/bin/bash

pacman -S emacs exa wofi alacritty zsh ttf-iosevka-nerd --noconfirm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -rf .oh-my-zsh/.git

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

rm -rf .oh-my-zsh/custom/themes/powerlevel10k/.git
