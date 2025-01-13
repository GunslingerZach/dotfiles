#!/usr/bin/env sh

# Like Luke Smith's Larbs but for me (zach)
# by GunslingerZach <gunslingerzach@waifu.club>
# License: GNU GPLv3

# configure the install
dotfilesrepo=[insert where it is locally or remotly]
progsfile=[same as above]
username=zach

### FUNCTIONS ###

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

makeuserjs(){
	# Get the Arkenfox user.js and prepare it.
	arkenfox="$pdir/arkenfox.js"
	overrides="$pdir/user-overrides.js"
	userjs="$pdir/user.js"
	ln -fs "/home/$name/.config/firefox/larbs.js" "$overrides"
	[ ! -f "$arkenfox" ] && curl -sL "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" > "$arkenfox"
	cat "$arkenfox" "$overrides" > "$userjs"
	chown "$name:wheel" "$arkenfox" "$userjs"
	# Install the updating script.
	mkdir -p /usr/local/lib /etc/pacman.d/hooks
	cp "/home/$name/.local/bin/arkenfox-auto-update" /usr/local/lib/
	chown root:root /usr/local/lib/arkenfox-auto-update
	chmod 755 /usr/local/lib/arkenfox-auto-update
	# Trigger the update when needed via a pacman hook.
	echo "[Trigger]
Operation = Upgrade
Type = Package
Target = firefox
Target = librewolf
Target = librewolf-bin
[Action]
Description=Update Arkenfox user.js
When=PostTransaction
Depends=arkenfox-user.js
Exec=/usr/local/lib/arkenfox-auto-update" > /etc/pacman.d/hooks/arkenfox.hook
}

installffaddons(){
	addonlist="ublock-origin darkreader vimium-ff libredirect"
	addontmp="$(mktemp -d)"
	trap "rm -fr $addontmp" HUP INT QUIT TERM PWR EXIT
	IFS=' '
	sudo -u "$name" mkdir -p "$pdir/extensions/"
	for addon in $addonlist; do
		if [ "$addon" = "ublock-origin" ]; then
			addonurl="$(curl -sL https://api.github.com/repos/gorhill/uBlock/releases/latest | grep -E 'browser_download_url.*\.firefox\.xpi' | cut -d '"' -f 4)"
		else
			addonurl="$(curl --silent "https://addons.mozilla.org/en-US/firefox/addon/${addon}/" | grep -o 'https://addons.mozilla.org/firefox/downloads/file/[^"]*')"
		fi
		file="${addonurl##*/}"
		sudo -u "$name" curl -LOs "$addonurl" > "$addontmp/$file"
		id="$(unzip -p "$file" manifest.json | grep "\"id\"")"
		id="${id%\"*}"
		id="${id##*\"}"
		mv "$file" "$pdir/extensions/$id.xpi"
	done
	chown -R "$name:$name" "$pdir/extensions"
	# Fix a Vim Vixen bug with dark mode not fixed on upstream:
	sudo -u "$name" mkdir -p "$pdir/chrome"
	[ ! -f  "$pdir/chrome/userContent.css" ] && sudo -u "$name" echo ".vimvixen-console-frame { color-scheme: light !important; }
#category-more-from-mozilla { display: none !important }" > "$pdir/chrome/userContent.css"
}

### THE ACTUAL SCRIPT ###

# Install the dotfiles in the user's home directory, but remove .git dir and
# other unnecessary files.
putgitrepo "$dotfilesrepo" "/home/$name" "$repobranch"
rm -rf "/home/$name/.git/" "/home/$name/README.md" "/home/$name/LICENSE" "/home/$name/FUNDING.yml"

# Make zsh the default shell for the user.
chsh -s /bin/zsh "$name"
sudo -u "$name" mkdir -p "/home/$name/.cache/zsh/"
sudo -u "$name" mkdir -p "/home/$name/.config/abook/"
sudo -u "$name" mkdir -p "/home/$name/.config/mpd/playlists/"

# Make dash the default #!/bin/sh symlink.
ln -sfT /bin/dash /bin/sh >/dev/null 2>&1

# Use system notifications for Brave on Artix
echo "export \$(dbus-launch)" >/etc/profile.d/dbus.sh

# All this below to get Librewolf installed with add-ons and non-bad settings.
browserdir="/home/$name/.librewolf"
profilesini="$browserdir/profiles.ini"

# Start librewolf headless so it generates a profile. Then get that profile in a variable.
sudo -u "$name" librewolf --headless >/dev/null 2>&1 &
sleep 1
profile="$(sed -n "/Default=.*.default-default/ s/.*=//p" "$profilesini")"
pdir="$browserdir/$profile"

git clone

[ -d "$pdir" ] && installffaddons

# Kill the now unnecessary librewolf instance.
pkill -u "$name" librewolf

# install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Cleanup
rm -f /etc/sudoers.d/larbs-temp
