#!/bin/bash

# check for argument
if [ -z "$1" ]; then
	# get random wallpaper
	wallpaper=$(ls ~/Wallpapers/Landscapes/* | shuf -n 1)
else
	# if it's a file, then set it as the background
	if [ -f $1 ]; then
		wallpaper=$1
	elif [ -d $1 ]; then
		# if it's a dir, then test to see that it's not empty
		dir="${1}*"
		if [ ${#dir[@]} -gt 0 ]; then
			wallpaper=$(ls $dir | shuf -n 1)
		else
			echo "Error: empty directory" 1>&2
			exit 1
		fi
	else
		echo "Error: argument not file/directory" 1>&2
		exit 1
	fi
fi

# apply it with pywal
wal -i $wallpaper -n

# source the colors
source ~/.cache/wal/colors.sh

# use feh to apply wallpaper
feh --bg-fil $wallpaper
