#!/bin/bash

#git init
#cat > .gitignore << EOF
#*
#EOF

pacman -S emacs exa wofi zsh ttf-iosevka-nerd --noconfirm

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp -rT dotfiles/.* ~
cp -r dotfiles/wallpapers ~
