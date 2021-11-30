#!/bin/env bash
echo "### Installing Fonts ###"
cd ~/post-install/
mkdir -p ~/.local/share/fonts/
cp -r ~/post-install/fonts ~/.local/share/fonts/post-install
echo 'Install Suckless'
cd
echo "### Installing DEPS ###"
if command -v pacman &> /dev/null
then
sudo pacman -S --noconfirm base-devel opendoas lm_sensors psmisc xsetroot zsh    
elif command -v xbps-install &> /dev/null
then
sudo -Syu xbps-install libXft-devel libX11-devel harfbuzz-devel libXext-devel libXrender-devel zsh libXinerama-devel base-devel psmisc opendoas lm_sensors xsetroot
fi
echo "### Installing Suckless programs ###"
mkdir -p ~/.config
git clone https://github.com/ysfgrgO7/Suckless.git ~/.config/suckless
cd ~/.config/suckless/dwm/
rm -f config.h
sudo make clean install
cd ../dmenu
rm -f config.h
sudo make clean install
cd ../st 
rm -f config.h
sudo make clean install
cd ~/.config/suckless/
echo "### Copying the *Doas* config ###"
sudo cp -r doas.conf /etc/doas.conf
echo "Creating Login Manager Entry for DWM"
sudo mkdir -p /usr/share/xsessions/
cd /usr/share/xsessions
sudo touch dwm.desktop
sudo chown $USER dwm.desktop
sudo cat > dwm.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=the dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF

echo 'Install Dots'
cd 
git clone https://github.com/ysfgrgO7/Dotfiles.git
mkdir -p ~/.config
cd ~/.config/
cp -r ~/Dotfiles/.xprofile ~/.xprofile
cp -r ~/Dotfiles/.config/alacritty/ ~/.config/alacritty
cp -r ~/Dotfiles/.config/doom/ ~/.config/doom
cp -r ~/Dotfiles/.config/picom/ ~/.config/picom
cp -r ~/Dotfiles/.config/ranger/ ~/.config/ranger
cp -r ~/Dotfiles/.config/rofi/ ~/.config/rofi
cp -r ~/Dotfiles/.config/VSCodium/ ~/.config/VSCodium
cp -r ~/Dotfiles/.config/zsh/ ~/.config/zsh/
cp -r ~/Dotfiles/.local/share/bin/ ~/.local/share/bin
mkdir ~/Media
mv ~/Downloads ~/Media/dl
mv ~/Documents ~/Media/doc
mv ~/Music ~/Media/mus
mv ~/Pictures ~/Media/pic
mv ~/Videos ~/Media/vid
mv ~/Templates ~/.local
mv ~/Public ~/.local
echo 'Install NVOID'
bash -c "$(curl -s https://raw.githubusercontent.com/ysfgrgO7/nvoid/main/.github/NVOID-Install.sh)"
