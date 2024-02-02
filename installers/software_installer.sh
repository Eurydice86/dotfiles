 #!/bin/bash

sudo pacman -Suy --noconfirm

sudo pacman -S --needed base-devel git --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru

sudo pacman -S wofi eza zsh firefox stow ttf-iosevka-nerd otf-font-awesome pulseaudio emacs python-lsp-server python-lsp-black python-isort rust-analyzer wl-clipboard --noconfirm

paru -S sddm-sugar-candy

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
stow -Svt ~ emacs

sudo stow -Svt / sddm

reboot
