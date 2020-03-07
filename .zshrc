# ruby
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# path stuff
export PATH=/usr/local/go:$PATH
export PATH=/Users/zachary.joffe/go:$PATH
export PATH=/Users/zachary.joffe/go/bin:$PATH
export PATH=/Users/zachary.joffe/.emacs.d/bin:$PATH
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/usr/local/opt/mariadb@10.1/bin:$PATH

export GOROOT=/usr/local/go
export GOPATH=/Users/zachary.joffe/go
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:"/usr/local/bin"
export PATH="/Users/zachary.joffe/.cargo/bin:$PATH"

# use nvim for default editor
export VISUAL=nvim
export EDITOR=nvim

# After sourcing zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(backward-kill-word)

# start tmux with zsh
if [ "$TMUX" = "" ]; then 
	tmux -u -2
fi

# prezto logic
#source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Withokta
if [ -f "/Users/zachary.joffe/.okta/okta-aws" ]; then
    . "/Users/zachary.joffe/.okta/okta-aws"
fi

# increase file limit
ulimit -S -n 2048

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# separate history for terminal sessions
# mainly used for tmux
setopt inc_append_history

# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# bash style kill word
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# WIP theme
#PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f> '

# get git branch
parse_git_branch() {
	ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || return
	echo " ($ref)"
}
setopt prompt_subst
PROMPT='%F{blue}%~%f$(parse_git_branch)> '

# quiet pushd/popd
setopt PUSHDSILENT

# antibody
source ~/.zsh_plugins.sh

## functions to make me less miserable
# pushd but don't change the directory
push() {
	pushd "$@"
	cd - > /dev/null
}

# push the currently checked out branch
gpo() {
	ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || return
	command git push origin $ref
}

# pull the currently checkout out brannch
gpull() {
	ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || return
	command git pull origin $ref
}

# colorful ls
export CLICOLOR=1

# colorful cd
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

fv() {
  if [ ! "$#" -gt 0 ]; then 
	nvim $(rg --files-with-matches --no-messages . | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 || rg --ignore-case --pretty --context 10 '$1' {}")
  else
    nvim $(rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}")
  fi
}

f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
fm() f "$@" --max-depth 1


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  #IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  #local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --tac)
  cd "$DIR"
}

# cdf - cd to parent dir of selected file
cdf() {
	if [ ! "$#" -gt 0 ]; then
		file=$(fzf)
	else
		file=$(fzf -q "$1")
	fi
	cd "$(dirname $file)"
}

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
