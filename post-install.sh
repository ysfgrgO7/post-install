#!/bin/bash

## Basic Setup
clear
if [ "$(id -u)" = 0 ]; then
    echo "##################################################################"
    echo "This script MUST NOT be run as root user since it makes changes"
    echo "to the \$HOME directory of the \$USER executing this script."
    echo "The \$HOME directory of the root user is, of course, '/root'."
    echo "We don't want to mess around in there. So run this script as a"
    echo "normal user. You will be asked for a sudo password when necessary."
    echo "##################################################################"
    exit 1
fi
clear
mkdir ~/post_installer

## Install deps
clear
echo '#### Installing deps ####'
if command -v pacman &> /dev/null
then
  sudo pacman -Syu --needed git curl neovim nodejs npm python-pip picom nitrogen ranger zsh exa stylua
elif command -v xbps-install &> /dev/null
then
  sudo xbps-install -Syu git curl neovim nodejs python3-pip picom nitrogen ranger zsh exa stylua
fi

## Install Dotfiles
clear
echo '#### Installing Dotfiles and fonts ####'
git clone https://github.com/ysfgrgO7/Dotfiles.git ~/post_installer/Dotfiles
~/post_installer/Dotfiles/install.sh

## Installing fonts
clear
cp -r ~/post-install/fonts/ ~/.local/share/fonts/post-fonts

## Installing Suckless
clear
echo '#### Installing Suckless ####'
git clone https://github.com/ysfgrgO7/Suckless.git ~/post_installer/Suckless
cd ~/post_installer/Suckless/
./install.sh
clear

## Installing Nvoid
clear
echo '#### Installing Nvoid ####'
echo '##########################################################'
echo '##########################################################'
echo '################ Say YES to the QUESTIONS ################'
echo '##########################################################'
echo '##########################################################'
bash -c "$(curl -s https://raw.githubusercontent.com/ysfgrgO7/nvoid/main/.github/installer.sh)"

## Installing lfetch
clear
git clone https://github.com/ysfgrgO7/lfetch.git ~/post_installer/lfetch
cd ~/post_installer/lfetch
sudo make install
echo 'lfetch' >> ~/.config/zsh/zsh-exports

## Removing extra directory
rm -rf ~/post_installer/

## Launch nitrogen and Set a wallpaper
clear
git clone https://github.com/ysfgrgO7/Wallpapers ~/Wallpapers
clear
echo '#########################################################################'
echo '#########################################################################'
echo '###### Chose A Wallpaper by runnig the cmd `nitrogen ~/Wallpapers` ######'
echo '#########################################################################'
echo '#########################################################################'
