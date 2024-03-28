# Dotfiles - fork of larbs
this is a work in progress fork of larbs for my own private use. Despite this, there is nothing stopping you from taking part or all of my dotfiles.

- Very useful scripts are in `~/.local/bin/`
- Settings for:
	- vim/nvim (text editor)
	- zsh (shell)
	- mpd/ncmpcpp (music)
	- mpv (video player)
	- other stuff like xdg default programs, inputrc and more, etc.
- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/shell/bm-files`
	- Directory bookmarks in `~/.config/shell/bm-dirs`

## Install these dotfiles and all dependencies

until I get this finished, the process is a little harder that how luke smith did it

```
pacman -S git
git clone https://github.com/GunslingerZach/dotfiles
cp voidrice
sh larbs.sh
```

or clone the repo files directly to your home directory and install the
[dependencies](https://github.com/GunslingerZach/dotfiles/blob/master/progs.csv).

## post install

no web browsers are installed so you will have to install one of your choice and customize it as you wish. An export of the configurations I use is present in the [firefox](firefox) directory

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
