# Dotfiles

A collection of configuration files for stuff on my system. 

## What is on here?

At this point I've made configs for i3, urxvt, and polybar. I'm not completely happy with my setup at the moment, so I'll either continue tweaking it or, more likely, switch to bspwm. I love the idea of tiling, but some thins that i3 do by default aren't to my preference. I'll keep the config files up here for archival sake though.

## Why aren't they organized?

Ideally, you'd just use symbolic links to get all the dotfiles. This, however, does not work as git reads the symlink at a directory, not a file/folder. To get around this, I've lazily copied all of the files into a local repo and pushed them onto GitHub. It would definitely be better to keep all the edits here and symlink them to their respective folders, but I don't love that setup to this is how it is for now. 

Perhaps I'll improve the file structure in the future, but as of now this repo is more of an archive than anything else. When I eventually get around to setting up bspwm I'll add config files to this repo.