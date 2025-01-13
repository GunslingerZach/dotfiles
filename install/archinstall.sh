#!/bin/sh

# dotfiles installation script based on larbs (larbs.xyz)
# by Gunslinger Zach <gunslingerzace@waifu.club>
# License: GNU GPLv3

# Check if running as root
if [ "${EUID:-"$(id -u)"}" -eq 0 ]; then
	printf "You shouldn't run this with elevated privileges (such as with doas/sudo).\n"
	exit 1
fi


#########################
#    Base variables     #
#########################

# Colors used for printing
RED='\033[0;31m'
BLUE='\033[0;34m'
BBLUE='\033[1;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# make sure your system is up to date before installing

# customize the Install
echo -n "Enter username: "
read name
echo -n "Enter preferred aurhelper: "
read aurhelper
echo "your username is $name and your preffered aurhelper is $aurhelper"
dotfilesrepo="../"
pacmanpackages="packagepacman"
aurpackages="aurpackages"

putgitrepo() {
	# Downloads a gitrepo $1 and places the files in $2 only overwriting conflicts
	[ -z "$3" ] && branch="master" || branch="$repobranch"
	dir=$(mktemp -d)
	[ ! -d "$2" ] && mkdir -p "$2"
	chown "$name":wheel "$dir" "$2"
	sudo -u "$name" git -C "$repodir" clone --depth 1 \
		--single-branch --no-tags -q --recursive -b "$branch" \
		--recurse-submodules "$1" "$dir"
	sudo -u "$name" cp -rfT "$dir" "$2"
}

# install the aurhelper
echo "--- install the aurhelper"
# git clone https://aur.archlinux.org/$aurhelper.git /home/$name/.local/src/$aurhelper
# cd /home/$name/.local/src/$aurhelper
# makepkg -si

# installs the packages from the aur
echo -e "${BBLUE}" "installs the packages from the aur"
$aurhelper -S $(cat packagepacman | cut -d' ' -f1 | sed '/#/d')

su

# Make pacman colorful, concurrent downloads and Pacman eye-candy.
echo -e "${BBLUE}" "Make pacman colorful, concurrent downloads and Pacman eye-candy."
grep -q "ILoveCandy" /etc/pacman.conf || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
sed -Ei "s/^#(ParallelDownloads).*/\1 = 5/;/^#Color$/s/#//" /etc/pacman.conf

# Use all cores for compilation.
echo -e "${BBLUE}" "Use all cores for compilation."
sed -i "s/-j2/-j$(nproc)/;/^#MAKEFLAGS/s/^#//" /etc/makepkg.conf

# Install the dotfiles in the user's home directory, but remove .git dir and
# other unnecessary files.
echo -e "${BBLUE}" "--- Install the dotfiles in the user's home directory, but remove .git dir and
other unnecessary files."
# putgitrepo "$dotfilesrepo" "/home/$name" "$repobranch"
# rm -rf "/home/$name/.git/" "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml" "/home/$name/install"

# Install vim plugins if not alread present.
echo -e "${BBLUE}" "Install vim plugins if not alread present."
[ ! -f "/home/$name/.config/nvim/autoload/plug.vim" ] && vimplugininstall

# Most important command! Get rid of the beep!
echo -e "${BBLUE}" "Most important command! Get rid of the beep!"
rmmod pcspkr
echo "blacklist pcspkr" >/etc/modprobe.d/nobeep.conf

# Make zsh the default shell for the user.
echo -e "${BBLUE}" "Make zsh the default shell for the user."
chsh -s /bin/zsh "$name" >/dev/null 2>&1
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
sudo -u "$name" mkdir -p "/home/$name/.config/mpd/playlists/"

# dbus UUID must be generated for Artix runit.
echo -e "${BBLUE}" "dbus UUID must be generated for Artix runit."
dbus-uuidgen >/var/lib/dbus/machine-id

# Use system notifications for Brave on Artix
echo -e "${BBLUE}" "Use system notifications for Brave on Artix"
echo "export \$(dbus-launch)" >/etc/profile.d/dbus.sh

# Enable tap to click
echo -e "${BBLUE}" "Enable tap to click"
[ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] && printf 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	# Enable left mouse button by tapping
	Option "Tapping" "on"
EndSection' >/etc/X11/xorg.conf.d/40-libinput.conf

# Allow wheel users to sudo with password and allow several system commands
# (like `shutdown` to run without password).
echo -e "${BBLUE}" "Allow wheel users to sudo with password and allow several system commands
---(like `shutdown` to run without password)."
echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/00-larbs-wheel-can-sudo
echo "%wheel ALL=(ALL:ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/pacman -S -y --config /etc/pacman.conf --,/usr/bin/pacman -S -y -u --config /etc/pacman.conf --" >/etc/sudoers.d/01-larbs-cmds-without-password
echo "Defaults editor=/usr/bin/nvim" >/etc/sudoers.d/02-larbs-visudo-editor
mkdir -p /etc/sysctl.d
echo "kernel.dmesg_restrict = 0" > /etc/sysctl.d/dmesg.conf
echo -e "${GREEN}" "assuming there were no errors, the install should be done you can read the full install log at $(pwd)/test.log. now reboot and everything should be set up."
