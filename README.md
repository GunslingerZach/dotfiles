# My dotfies (GunslingerZach) <https://gunslingerzach.xyz>'s dotfiles)

This is a wip fork of [LARBS](https://larbs.xyz) to suit my usecase
## software used
 - swaywm (window manager)
  - waybar
 - foot (terminal)
  - alacritty (alternitive terminal)
 - vim/nvim (terminal text editor)
 - emacs (gui text editor configured to work like vim)
 - zsh (shell)
 - lf (terminal file manager)
	- mpd/ncmpcpp (music)
	- nsxiv (image/gif viewer)
	- mpv (video player)
- Very useful scripts are in `~/.local/bin/`
- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/shell/bm-files`
	- Directory bookmarks in `~/.config/shell/bm-dirs`

## Install these dotfiles and all dependencies

You can either install this manually or automatically. 

- automatically - run the [zlarbs.sh](zlarbs.sh) script. download it and run it

```
curl -LO [insert git repo url]/zlarbs.sh
zlarbs.sh
```

- manually - install any missing software and the clone the contents of this repo to $HOME

## wallpaper

I use [0123.jpg](.local/share/0123.jpg) from ditrotube's [wallpaper collection](https://gitlab.com/dwt1/wallpapers)

If you want more wallpapers, here's some git repo's

``` shell
git clone [https://github.com/D3Ext/aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers)
git clone [https://github.com/AngelJumbo/gruvbox-wallpapers](https://github.com/AngelJumbo/gruvbox-wallpapers)
git clone [https://github.com/salman-abedin/eyelust](https://github.com/salman-abedin/eyelust)
```


## todo 
- offline install
- replace lf with dired in emacs

# tips
This is in Luke Smith's config however it isn't universally usefull so I will leave it as a optional post install thing

## Use system notifications for Brave on Artix
echo "export \$(dbus-launch)" >/etc/profile.d/dbus.sh
## setup abook
sudo -u "$name" mkdir -p "/home/$USER/.config/abook/"
