 #!/bin/bash

sudo pacman -Suy --noconfirm

sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru

sudo pacman -S wofi exa zsh stow ttf-iosevka-nerd emacs --noconfirm

chsh -s $(which zsh) $USER

cd ~

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k

cd dotfiles

stow -Svt ~ *

mv wallpapers ~
reboot
