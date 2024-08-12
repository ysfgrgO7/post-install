#!/bin/bash

if command -v pacman &>/dev/null; then
	echo ""
else
	exit 1
fi

# Basic Setup
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
rm -rf ~/.post_install/
git clone https://github.com/ysfgrgO7/post-install ~/.post_install/
cd ~/.post_install/
cp -r ~/.config/ ~/.configoldbc

# Fonts
clear
echo "Installing Fonts"
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir newfont
mv JetBrainsMono.tar.xz newfont
cd newfont
tar xf JetBrainsMono.tar.xz
cd ../
sudo cp -r newfont /usr/share/fonts/
sudo fc-cache -fv
cd ~/.post_install

# Install Paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Install Dependencies
sudo pacman -Syu --noconfirm --needed base-devel cmake fd ripgrep git zsh fzf exa alacritty kitty rofi neovim python-pip python-pynvim nodejs npm yarn ranger lua lua51
paru -S --needed --noconfirm awesome-git brave-bin sddm-git

# SDDM
sudo systemctl disable $(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}')
sudo systemctl enable sddm

# Dotfiles
cd ~/.post_install
git clone https://github.com/ysfgrgO7/Dotfiles
cp -r ~/.post_install/Dotfiles/ranger/ ~/.config/
cp -r ~/.post_install/Dotfiles/user-dirs.dirs ~/.config/
cp -r ~/.post_install/Dotfiles/alacritty/ ~/.config/
cp -r ~/.post_install/Dotfiles/kitty/ ~/.config/
cp -r ~/.post_install/Dotfiles/awesome/ ~/.config/
cp -r ~/.post_install/Dotfiles/river/ ~/.config/
cp -r ~/.post_install/Dotfiles/rofi/ ~/.config/
cp -r ~/.post_install/Dotfiles/bin/ ~/.local/share/bin
cp -r ~/.post_install/Dotfiles/zshrc ~/.zshrc

mkdir ~/Media
mv ~/Downloads ~/Media/dl
mv ~/Documents ~/Media/doc
mv ~/Music ~/Media/mus
mv ~/Pictures ~/Media/pic
mv ~/Videos ~/Media/vid
mv ~/Templates ~/.local
mv ~/Public ~/.local

# lfetch
cd ~/.post_install/
git clone https://github.com/ysfgrgO7/lfetch.git
cd lfetch
sudo make install

# Nvoid
rm -rf ~/.post_install/
mkdir ~/git
cd ~/git/
git clone https://github.com/ysfgrgO7/Dotfiles

while true; do
	read -p "Do you want to reboot? [Y/n] " yn
	case $yn in
	[Yy]*) reboot ;;
	[Nn]*) break ;;
	"") reboot ;;
	*) echo "Please answer yes or no." ;;
	esac
done
