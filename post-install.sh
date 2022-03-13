#!/bin/bash

clear
mkdir ~/post_installer
## Install deps
echo '#### Installing deps ####'
if command -v pacman &> /dev/null
then
  sudo pacman -Syu --needed git curl neovim nodejs npm python-pip picom nitrogen ranger zsh
elif command -v xbps-install &> /dev/null
then
  sudo xbps-install -Syu git curl neovim nodejs python3-pip picom nitrogen ranger zsh
fi
clear
## Install Dotfiles
echo '#### Installing Dotfiles and fonts ####'
git clone https://github.com/ysfgrgO7/Dotfiles.git ~/post_installer/Dotfiles
cp -r ~/post_installer/Dotfiles/.config/picom/ ~/.config/picom
cp -r ~/post_installer/Dotfiles/.config/ranger/ ~/.config/ranger
cp -r ~/post_installer/Dotfiles/.config/zsh/ ~/.config/zsh
cp -r ~/post_installer/Dotfiles/.config/user-dirs.dirs ~/.config/user-dirs.dirs
mkdir ~/Media
mv ~/Downloads ~/Media/dl
mv ~/Documents ~/Media/doc
mv ~/Music ~/Media/mus
mv ~/Pictures ~/Media/pic
mv ~/Videos ~/Media/vid
mv ~/Templates ~/.local
mv ~/Public ~/.local
cp -r ~/post-install/fonts/ ~/.local/share/fonts/post-fonts
## Installing Suckless
echo '#### Installing Suckless ####'
git clone https://github.com/ysfgrgO7/Suckless.git ~/post_installer/Suckless
cd ~/post_installer/Suckless/
./install.sh
clear
## Installing Nvoid
echo '#### Installing Nvoid ####'
echo '##########################################################'
echo '##########################################################'
echo '################ Say YES to the QUESTIONS ################'
echo '##########################################################'
echo '##########################################################'
bash -c "$(curl -s https://raw.githubusercontent.com/ysfgrgO7/nvoid/main/.github/installer.sh)"
## Launch nitrogen and Set a wallpaper
clear
echo '###################################################'
echo '###################################################'
echo '################ Chose A Wallpaper ################'
echo '###################################################'
echo '###################################################'
nitrogen ~/Wallpapers/
