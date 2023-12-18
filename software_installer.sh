 #!/bin/bash

pacman -Suy --noconfirm
pacman -S stow emacs exa wofi zsh ttf-iosevka-nerd --noconfirm

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k

stow -d $HOME/dotfiles/ .dotfiles -t $HOME

chsh -s $(which zsh) $USER
