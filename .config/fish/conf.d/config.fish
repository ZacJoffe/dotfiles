# env vars
set -x GOROOT (go env GOROOT)
set -x GOPATH ~/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
set -x PATH $PATH ~/.emacs.d/bin/
set -x PATH $PATH ~/.local/bin/
set -x EDITOR nvim

set -gx SXHKD_SHELL /usr/bin/bash

# fzf theme
# modified version of https://github.com/ianchesal/nord-fzf
set -x FZF_DEFAULT_OPTS '--color=fg:#d8dee9,bg:#2e3440,hl:#81a1c1,fg+:#d8dee9,bg+:#2e3440,hl+:#81a1c1,info:#eacb8a,prompt:#bf6069,pointer:#b48dac,marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# set manpager to bat
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# bat theme
set -x BAT_THEME Nord

# aliases
# exa instead of ls
alias l="exa"
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'

# bat instead of cat
alias cat='bat --style=plain'

thefuck --alias | source 
