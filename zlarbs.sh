#!/usr/bin/env sh

# Like Luke Smith's Larbs but for me (zach)
# by GunslingerZach <gunslingerzach@waifu.club>
# License: GNU GPLv3

# usefull alias
home=/home/$USER
timestamp=$(date +%s)

# variables
larbs_dotfiles_remote=https://github.com/lukesmithxyz/voidrice
zach_dotfiles_remote=https://github.com/gunslingerzach/dotfiles
packages=same as above
## supported distros are arch and artix-runit. If you are using parabola
## then just choose what is equivilant (arch if systemd artix-runit if runit)
distro=artix-runit
## this is used to simplify the script whenever possible.
like=arch

# setup the dotfiles config
mkdir -p $home/.config/dotfiles
mkdir $home/.config/dotfiles/larbs
mkdir $home/.config/dotfiles/zach
git clone $luke_dotfiles
git clone $zach_dotfiles

# give the dotfiles repo propper alias'
dotfiles_config=$home/.config/dotfiles
larbs=$dotfiles_config/larbs
zlarbs=$dotfiles_config/zach

# loop to symlink all the .config folders
for larbs_config in gtk-2.0 gtk-3.0 mpv mpv ncmpcpp wget zathura; do
    ln -s "$larbs/.config/$larbs_config" "$home/.config/"
done

for zlarbs_config in alacritty doom fastfetch foot lf nvim sway waybar shell zsh user-dirs.dirs mimeapps.list; do
    ln -s "$larbs/.config/$zlarbs_config" "$home/.config/"
done

# .zprofile needs to be in two places at once
###! WARNING - THIS WILL REPLACE YOUR .zprofile if there is already one there !###
ln -sf "$home/.config/shell/profile" "$home/.zprofile"

# handles .local/bin
test -d $home/.local/bin || mkdir -p "$home/.local/bin"
ln -f "$larbs/.local/bin/*" "$home/.local/bin/"
ln -f "$zlarbs/.local/bin/*" "$home/.local/bin/"

# handles the applications directoryin a way that more
# can be added without git wiping it out
test -d $home/.local/share/applications || mkdir -p "$home/.local/share/applications"
ln -s "$zlarbs/.local/share/applications/*" "$home/.local/share/applications/"

# handles the .local/share folder
ln -f "$larbs/.local/share/larbs" "$home/.local/share/"
ln -f "$zlarbs/.local/share/zlarbs" "$home/.local/share/"
ln "$larbs/.local/share/thiemeyer_road_to_samarkand.jpg" "$home/.local/share/"
ln "$zlarbs/.local/share/0123.jpg" "$home/.local/share/"

# distro specific
if [ $like=arch ]; then

 # install paru
 git clone https://aur.archlinux.org/paru.git $home/.local/src/paru
 cd .local/src/paru
 makepkg -si

 ###! VERY IMPORTANT - THE FOLLOWING IS RUN AS ROOT !###
 su root

 # installs the packages from the main repo
 if [ $distro=artix-runit ]; then
  pacman -S --noconfirm --needed -S artix-keyring artix-archlinux-support
  mv -f $home/.config/dotfiles/artix/pacman.conf /etc/
  pacman -Sy --noconfirm
  pacman-key --populate archlinux
 fi
 [ $distro!=artix-runit ] && mv -f $home/.config/dotfiles/arch/pacman.conf /etc/
 pacman -Syu --noconfirm
 pacman --noconfirm --needed -S $(cat packagepacman | cut -d' ' -f1 | sed '/#/d')

 # Make pacman colorful, concurrent downloads and Pacman eye-candy.
 grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
 sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

 # Use all cores for compilation.
 sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf
 if [ $distro=artix-runit ]; then
  # dbus UUID must be generated for Artix runit.
  dbus-uuidgen >/var/lib/dbus/machine-id
  # Use system notifications for Brave on Artix
  echo "export \$(dbus-launch)" >/etc/profile.d/dbus.sh
 fi
 exit
fi

# Most important command! Get rid of the beep!
# rmmod pcspkr
# echo "blacklist pcspkr" >/etc/modprobe.d/nobeep.conf

# Make zsh the default shell for the user.
[ $SHELL != /bin/zsh ] chsh -s /bin/zsh "$USER"
test -d $home/.cache/zsh || mkdir -p "$home/.cache/zsh/"
test -d $home/.config/mpd/playlists || mkdir -p "$home/.config/mpd/playlists/"

# Make dash the default #!/bin/sh symlink.
ln -sfT /bin/dash /bin/sh >/dev/null 2>&1

# install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
$HOME/.config/emacs/bin/doom install
