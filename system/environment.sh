# Common environment

#
# Set PATH
#
# We just re-set PATH here in case anybody messes with it, and such that we don't keep appending when
# we source this file multiple times. Note: generally, I want access to applications installed using
# Homebrew first. It installs in /usr/local/bin.
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$DOTFILES/system/bin
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"

# Environment for less; enable raw ANSI characters and case insensitive search
export LESS=-Ri

# Mac environment
[[ -n $MAC ]] && {
	# Extend the path for user-install pip packages on mac
	PATH=$PATH:$HOME/Library/Python/3.7/bin
}

# Linux environment
[[ -n $LINUX ]] && {
	PATH=$PATH:$HOME/.local/bin/
	# XDG_CONFIG_DIRS: Well-behaved applications will search these folders for configuration data
	# export XDG_CONFIG_DIRS=$DOTFILES/config:~/.config
}

