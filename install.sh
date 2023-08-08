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
if command -v paru &>/dev/null; then
	echo "You Have Paru"
else
	sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
fi
cd ~/.post_install

# Install Dependencies
if command -v pacman &>/dev/null; then
	sudo pacman -Syu --noconfirm --needed git zsh fzf exa alacritty waybar hyprland rofi swaybg neovim python-pip python-pynvim nodejs npm yarn ranger lua lua51
	paru -S --needed --noconfirm brave-bin sddm-git
else
	echo "Only works with ARCH"
fi

# SDDM
sudo systemctl disable $(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service | awk -F / '{print $NF}')
sudo systemctl enable sddm

# Dotfiles
cd ~/.post_install
git clone https://github.com/ysfgrgO7/Dotfiles
cp -r ~/.post_install/Dotfiles/ranger/ ~/.config/
cp -r ~/.post_install/Dotfiles/zshrc ~/.zshrc
cp -r ~/.post_install/Dotfiles/user-dirs.dirs ~/.config/
cp -r ~/.post_install/Dotfiles/alacritty/ ~/.config/
cp -r ~/.post_install/Dotfiles/bin/ ~/.local/share/bin

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

# Waybar
rm -rf ~/.config/hypr/
git clone https://github.com/ysfgrgO7/wayland-config ~/.config/hypr/

# Nvoid
bash <(curl -s https://raw.githubusercontent.com/nvoid-lua/nvoid/main/utils/installer/install.sh)

rm -rf ~/.post_install/

while true; do
	read -p "Do you want to reboot? [Y/n] " yn
	case $yn in
	[Yy]*) reboot ;;
	[Nn]*) break ;;
	"") reboot ;;
	*) echo "Please answer yes or no." ;;
	esac
done
