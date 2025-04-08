# my dotfiles

# My dotfies (GunslingerZach) <https://gunslingerzach.xyz>'s dotfiles)
This is a wip fork of [LARBS](https://larbs.xyz) to suit my usecase. I also copied from [horriblename](https://github.com/horriblename/lfimg-sixel)'s github to use sixel instead of lf
## software used
 - swaywm (wayland only)
 - waybar (wayland only)
 - foot (terminal) (wayland only)
 - alacritty (alternitive terminal)
 - vim/nvim (terminal text editor)
 - emacs (gui text editor configured to work like vim)
 - zsh (shell)
 - lf (terminal file manager)
 - nsxiv (image/gif viewer)
 - mpv (video player)
- Very useful scripts are in `~/.config/scripts/`
- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
    - Further, all configs in this repo are in `~/.config/` with `.zshenv` being the only exception for zsh
	- Some environmental variables have been set in `~/.config/zsh/.zprofile` to move configs into `~/.config/`
## install
backup your dotfiles
~~~
mkdir ~/backupdir
mv ~/.* ~/backupdir
~~~
git clone the repo (make sure you have git installed)
~~~
git clone "https://github.com/gunslingerzach/dotfiles" ~/.dotfiles
~~~
Make zsh the default shell for the user and use dash for /bin/sh
~~~
[ $SHELL != /bin/zsh ] chsh -s /bin/zsh "$USER"
mkdir -p "$home/.cache/zsh/"
mkdir "$HOME/.config/zsh"
# Make dash the default #!/bin/sh symlink.
ln -sfT /bin/dash /bin/sh >/dev/null 2>&1
~~~

use stow (requires stow)
~~~
stow ~/.dotfiles
~~~

make a .local directory if there isn't one already and then place certain files in it
~~~
mkdir $HOME/.local
cp ~/.dotfiles/.local/share/applications ~/.local/share/
cp ~/.dotfiles/.local/share/larbs ~/.local/share/
~~~

move a wallpaper to ~/.local/share/bg otherwise sway will whine that it doesn't exist. If you are lazy, there is already one in .local/share/
~~~
cp ~/.dotfiles/.local/share/0123.jpg ~/.local/share/bg
~~~

install doom emacs (source https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)

~~~
git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
$HOME/.config/emacs/bin/doom install
~~~

### wallpaper

I use [0123.jpg](.local/share/0123.jpg) from ditrotube's [wallpaper collection](https://gitlab.com/dwt1/wallpapers)

If you want more wallpapers, here's some git repo's

``` shell
git clone [https://github.com/D3Ext/aesthetic-wallpapers](https://github.com/D3Ext/aesthetic-wallpapers)
git clone [https://github.com/AngelJumbo/gruvbox-wallpapers](https://github.com/AngelJumbo/gruvbox-wallpapers)
git clone [https://github.com/salman-abedin/eyelust](https://github.com/salman-abedin/eyelust)
```
## post install

On arch based systems I like to uncomment the color option and add "ILoveCandy" in /etc/pacman.conf

## todo

- [ ] learn what packages are required
- [ ] test on arch
- [ ] test on artix
- [ ] test on parabola
- [ ] test on debian
- [ ] test on devuan
- [ ] test on ubuntu
- [ ] test on mint
- [ ] test on gentoo
