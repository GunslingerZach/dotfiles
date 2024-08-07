# Dotfiles - fork of larbs
this is a work in progress fork of larbs for my own private use. Despite this, there is nothing stopping you from taking part or all of my dotfiles.

- Very useful scripts are in `~/.local/bin/`
- Hyprland is the default tiling window manager
	- with Luke Smith's dwm
- waybar is the bar for hyprland
- mpv is the video player
- imv is the image viewer
- zathura is the pdf veiwer
- sway-launcher-desktop is the application launcher with rofi as an alternitive
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

## supported distros

Arch linux as well as parabola GNU/Linux-libre. Theoretically there is no reason why it cannot work on artix linux however it has not been tested yet. Tested on my gamming machine using an AMD gpu as well as a thinkpad x220 and a thinkpad t400 (running parabola) On parabola I was not able to get hyprland to display properly using the official package so I had to use the aur pacage hyprland-legacyrenderer.

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

I do not ship "xdg-desktop-portal-hyprland" because one of its dependencies is geoclue. Geoclue is blacklisted by parabola's your-privacy. The hack I found was to install xdg-desktop-portal-hyprland and then run "pacman -Rdd geoclue" and then installing your-privacy.  

## hyprland plugins

starting hyprland will probrably give you an error. This is because I use [hyprsplit](https://github.com/shezdy/hyprsplit). hyprsplit makes it so that every monitor has 10 unique worspaces to itself. This is contrasted with the default where the 10 workspaces are shared between every monitor. To install hyprsplit run the following commands

```
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit
```

## known bugs

the script will error out when installing an aur helper. To fix this I removed all of the aur packages. you can install the extra packages by installing an aur helper and then using that to install those packages. Because the aur is by definition chaotic and not supported by parabola, I try to keep aur packages to a minimum

to insttall the aur helper run

```
cd ~/.local/src/
git clone https://aur.archlinux.org/paru.git
makepkg -si
```
then run

```
paru -S tofi
```

note that you cannot install paru as root so you have to install it as a user. Make sure that your user is in the sudoers file (/etc/sudoers)

Hyprland headers will fail sometimes. This is because the aur package for hyprland doesn't install all of the nessisary packages. I have added some in the [progs.csv](progs.csv) file. If you are still getting an error then report it.
