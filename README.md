# Dotfiles

A collection of configuration files for my bspwm rice.

## What's on this repo?

Originally, I created this repo for my dotfiles relating to an i3 config I was working on. I got to the point where I realized I didn't like i3 all that much, so I decided to try bspwm as an alternative. I find it to be far better than i3, so I doubt I'll work on any of the i3 dotfiles anymore. Unless that happens, now this is exclusively a bspwm rice.

Once I'm happy with the setup, I'll probably not work on it for a while. However, I'll likely get bored of it eventually and I'll continue to keep this repo up to date with my latest rice.

## Why aren't they organized properly?

Ideally, you'd just use symbolic links to get all the dotfiles. This, however, does not work as git reads the symlink at a directory rather than a file or folder. To get around this, I've lazily copied all of the files into a local repo and pushed them onto GitHub. It would definitely be better to keep all the edits here and symlink them to their respective folders, but I don't love that setup to this is how it is for now.

## To do list:
- [X] Finish ricing polybar
- [X] Fix mouse acceleration
- [X] Organize repo (for the most part)
- [X] Cmus integration
- [X] Dunst integration 

Well everything that is here is completely functional. I still would like to improve the dunst integration, perhaps try to use another terminal (like alacritty), and figure out a way to make compton behave with games better. I will also update my vimrc as I add more plugins and continue learning to use vim.
