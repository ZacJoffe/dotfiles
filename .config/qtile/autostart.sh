#!/bin/sh

# randomly select a wallpaper
wallpaper=$(ls ~/Wallpapers/Landscapes/* | shuf --random-source=/dev/urandom -n 1)

# set randomized wallpaper from start of config with feh
feh --bg-fill $wallpaper

picom &
