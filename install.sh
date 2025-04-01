#!/usr/bin/env sh

# note this is currently just documentation as I build this

# Make zsh the default shell for the user.
[ $SHELL != /bin/zsh ] chsh -s /bin/zsh "$USER"
mkdir -p "$home/.cache/zsh/"
mkdir "$HOME/.config/zsh"

# Make dash the default #!/bin/sh symlink.
ln -sfT /bin/dash /bin/sh >/dev/null 2>&1

# fix for mpd
mkdir -p "$home/.config/mpd/playlists/"

# make a .local directory if it doesn't exist
mkdir $HOME/.local

# stow everything
stow ~/

# install doom emacs (source https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install)
git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
$HOME/.config/emacs/bin/doom install

# note nvchad installs on first run
