set -x GOROOT (go env GOROOT)
set -x GOPATH ~/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin


cat ~/.cache/wal/sequences

thefuck --alias | source 