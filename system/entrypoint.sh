# Intended as entry point for my other dot files, at least the ones that are shell related.
# Suggestion: remove your bashrc/bash_profile and create a symlink to this file instead.
# Or source it from that file.

# Reference this repo directory
export DOTFILES=$HOME/.dotfiles

# Set to any non-empty string for debug prints
export DEBUG=${DEBUG-''}
echo "DEBUG is set to $DEBUG"

# Use colors in the terminal
export CLICOLOR=1

#
# Debug logging
#
dprint() {
    if [[ -n $DEBUG ]]; then echo -e "\033[1m[DEBUG] $1\033[0m"; fi
}
export -f dprint

#
# Easier-to-remember platform checks
#
if [[ $(uname) == Darwin ]]; then
    dprint "setting MAC"
    export MAC="I'm a mac!"
    export LINUX=''
else
    dprint "setting LINUX"
    export MAC=''
    export LINUX="I'm a Linux box"
fi

#
# Get our own directory
#
# If this file is called from a symlink, follow it; otherwise, get the current dir name.
# BASH_SOURCE is the name of the file that's currently being sourced.
THIS_DIR=~/.dotfiles/system  # Provide sensible default in case commands below fail
[[ -f $BASH_SOURCE ]] && THIS_DIR=$(dirname $BASH_SOURCE)
[[ -L $BASH_SOURCE ]] && THIS_DIR=$(dirname $(readlink $BASH_SOURCE))

#
# Call other files
#
source_and_log() {
	dprint "Sourcing $1..." && . "$1"
}
dprint "THIS_DIR = $THIS_DIR"
source_and_log "$THIS_DIR/alias.sh"
source_and_log "$THIS_DIR/functions.sh"
source_and_log "$THIS_DIR/environment.sh"

# Bash completion (for git on Mac)
[[ $SHELL =~ bash && -n $MAC && -f $(brew --prefix)/etc/bash_completion ]] && . "$(brew --prefix)/etc/bash_completion"

#
# Powerline
#
command -v powerline-daemon > /dev/null && {
	# powerline found
	powerline-daemon -q
	export POWERLINE_BASH_CONTINUATION=1
	export POWERLINE_BASH_SELECT=1
	[[ -n $MAC ]] && [[ $SHELL =~ bash ]] && . ~/Library/Python/3.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh
	[[ -n $MAC ]] && [[ $SHELL =~ zsh ]] && . ~/Library/Python/3.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
}
