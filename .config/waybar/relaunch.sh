#!/usr/bin/env sh

killall waybar # Kill all instances of waybar
sway reload
waybar &       # Launch statusbar
