 #!/bin/bash

pacman -Suy --noconfirm
pacman -S stow emacs exa wofi zsh ttf-iosevka-nerd --noconfirm

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

stow -d dotfiles/ .dotfiles -t ~

chsh -s $(which zsh) $USER
