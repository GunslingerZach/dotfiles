# Dotfiles - fork of larbs
this is a work in progress fork of larbs for my own private use. Despite this, there is nothing stopping you from taking part or all of my dotfiles.

- Very useful scripts are in `~/.local/bin/`
- Hyprland is the default tiling window manager
	- with Luke Smith's dwm
- waybar is the bar for hyprland
- mpv is the video player
- imv is the image viewer
- zathura is the pdf veiwer
- rofi is the application launcher
- Foot is the default terminal
	- with Luke Smith's fork of st
plus these terminal based applications
- newsboat is the rss reader
- ncmpcpp is the music player
- nmtui is the network manager
- neovim is the text editor

- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/shell/bm-files`
	- Directory bookmarks in `~/.config/shell/bm-dirs`

## Install these dotfiles and all dependencies

until I get this finished, the process is a little harder that how Luke Smith did it

```
pacman -S git
git clone https://github.com/GunslingerZach/dotfiles
cp dotfiles
sh larbs.sh
```

or clone the repo files directly to your home directory and install the
[dependencies](https://github.com/GunslingerZach/dotfiles/blob/master/progs.csv).

## post install

no web browsers are installed so you will have to install one of your choice and customize it as you wish. Install your favorite brower and replace it with the keybind in Hyprland for firefox.

## hyprland plugins

starting hyprland will probrably give you an error. This is because I use [hyprsplit](https://github.com/shezdy/hyprsplit). hyprsplit makes it so that every monitor has 10 unique worspaces to itself. This is contrasted with the default where the 10 workspaces are shared between every monitor. To install hyprsplit run the following commands

```
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit
```

## known bugs

the script will error out when installing yay. The only solution I have found is to manually install it then run the script.

```
cd ~/.local/src/
git clone https://aur.archlinux.org/yay.git
makepkg -si
```

Hyprland headers will fail sometimes. This is because the aur package for hyprland doesn't install all of the nessisary packages. I have added some in the [progs.csv](progs.csv) file. If you are still getting an error then report it.
