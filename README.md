# Post Install
![post-install](https://user-images.githubusercontent.com/94284073/158056122-7bc9aeaa-b426-445b-934a-054daf368819.png)

A bash script that install [My Suckless](https://github.com/ysfgrgO7/Suckless) programs with it's dependencies and [Dotfiles](https://github.com/ysfgrgO7/Dotfiles), also installs [Nvoid](https://github.com/nvoid-lua/nvoid)

>Note: It only works for arch and gnu/void linux and their distributions
## Install
```bash
git clone https://github.com/ysfgrgO7/post-install
cd post-install
./post-install.sh
```
>make sure that your not logged in as root because the script won't work
## What does it do?
### Install Dependencies
#### the script installs 
1. git
1. curl
1. neovim
1. nodejs (with npm)
1. pip
1. picom
1. nitrogen
1. ranger
1. zsh
### Install Dotfiles
the script just installs the files for ranger, picom, zsh
### Install Suckless
it clones the repo and run the `install.sh` which install some build dependencies and builds them
### Install Nvoid
it runs the [nvoid installer](https://github.com/nvoid-lua/nvoid#install-in-one-command)
>say `yes` or `y` to the questions in the installer

then it creates a custom config for it to set the catppuccin theme

### Choose The wallpaper When nitrogen opens
Clone the wallpapers repo then opens it in nitrogen to choose the wallpaper
