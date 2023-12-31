 #!/bin/bash

sudo pacman -Suy --noconfirm

sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru

sudo pacman -S wofi exa zsh stow ttf-iosevka-nerd emacs --noconfirm

paru -S sddm-sugar-dark

chsh -s $(which zsh) $USER

cd ~

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k

cd dotfiles

stow -Svt ~ sway
stow -Svt ~ wofi
stow -Svt ~ waybar
stow -Svt ~ foot
stow -Svt ~ zsh
stow -Svt ~ wallpapers

sudo stow -Svt / sddm

reboot
