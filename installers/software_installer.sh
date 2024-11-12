 #!/bin/bash

sudo pacman -Suy --noconfirm

sudo pacman -S --needed base-devel git --noconfirm

git config --global init.defaultBranch main
git config --global user.name Eurydice86
git config --global user.email kyriakopoulos.nikos@gmail.com

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru

sudo pacman -S wofi pacman-contrib waybar eza zsh atuin thunar btop stow ttf-iosevka-nerd noto-fonts-emoji pulseaudio emacs python-lsp-server python-lsp-black python-isort rust-analyzer cmake wl-clipboard clang zoxide vlc thefuck go gopls --noconfirm

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
stow -Svt ~ cava

paru -S cava
paru -S waylogout-git
paru -S google-chrome

reboot
