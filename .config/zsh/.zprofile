#!/bin/sh
# shellcheck disable=SC2155

# Profile file, runs on login. Environmental variables are set here.

# Add all directories in `~/.local/bin` to $PATH
export PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':' -)"
export PATH="$PATH:$(find ~/.config/scripts -type d | paste -sd ':' -)"
export PATH="$PATH:$(find ~/.config/scripts/zach/ -type d | paste -sd ':' -)"
export PATH="$PATH:$(find ~/.config/scripts/luke/ -type d | paste -sd ':' -)"

unsetopt PROMPT_SP 2>/dev/null

# Default programs:
export EDITOR="nvim"
export TERMINAL="foot"
export TERMINAL_PROG="st"
export BROWSER="librewolf"

# Change the default crypto/weather monitor sites.
# export CRYPTOURL="rate.sx"
# export WTTRURL="wttr.in"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export HISTFILE="$XDG_DATA_HOME/history"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse"
export LESS="R"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export MOZ_USE_XINPUT2=1                  # Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D" # May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1      # Fix for Java applications in dwm
export GRIM_DEFAULT_DIR="$HOME/pictures/screenshots/grim"
export SWAY_SCREENSHOT_DIR="$HOME/pictures/screenshots/sway-screenshots/"
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME="qt6ct"        # Have QT use gtk2 theme.
[ ! -f "$XDG_CONFIG_HOME/shell/shortcutrc" ] && setsid -f shortcuts >/dev/null 2>&1

# Start graphical server on user's current tty if not already running.
# [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
#if [[ "$(tty)" = "/dev/tty1" ]]; then
#    exec dbus-run-session sway
#fi

[ "$(tty)" = "/dev/tty1" ] && exec dbus-run-session sway && export $ZACH_DESKTOP="sway"
# [ "$(tty)" = "/dev/tty1" ] && exec sway

# make qt apps respect dark mode (qt5)
QT_LOGGING_RULES="qt.svg*.warning=false"
QT_QPA_PLATFORMTHEME=qt5ct

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys "$XDG_DATA_HOME/larbs/ttymaps.kmap" 2>/dev/null
