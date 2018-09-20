# Dotfiles

A collection of configuration files for my bspwm rice.

## What is on this repo?

Originally, I created this repo for my dotfiles relating to an i3 config I was working on. I got to the point where I realized I didn't love i3, so I decided to try bspwm as an alternative. I find it to be far better than i3, so I doubt I'll work on any of the i3 dotfiles anymore. I'll keep them up here for archival's sake, but for now this is exclusively a bspwm rice.

Once I'm happy with the setup, I'll probably not update it for a while. However, I'll likely get bored of it eventually and I'll continue to keep this repo up to date with my latest rice.

## Why aren't they organized?

Ideally, you'd just use symbolic links to get all the dotfiles. This, however, does not work as git reads the symlink at a directory, not a file/folder. To get around this, I've lazily copied all of the files into a local repo and pushed them onto GitHub. It would definitely be better to keep all the edits here and symlink them to their respective folders, but I don't love that setup to this is how it is for now.

Perhaps I'll improve the file structure in the future, but as of now this repo is more of an archive than anything else.

## To do list:
- [ ] Finish ricing polybar
- [ ] Fix mouse acceleration
- [ ] Cmus integration
- [ ] Dunst integration (or another notification manager)
- [ ] Fix gaming performance (likely due to compton)