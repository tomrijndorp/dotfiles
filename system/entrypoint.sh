# Intended as entry point for my other dot files, at least the ones that are shell related.
# Suggestion: remove your bashrc/bash_profile and create a symlink to this file instead.
# Or source it from that file.

# Reference this repo directory
export DOTFILES=$HOME/.dotfiles

# Set to any non-empty string for debug prints
export DEBUG='yes'

# Use colors in the terminal
export CLICOLOR=1

#
# Debug logging
#
dprint() {
    [[ -n $DEBUG ]] && echo -e "\033[1m[DEBUG] $1\033[0m"
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
# Set PATH
#
# We just re-set PATH here in case anybody messes with it, and such that we don't keep appending when
# we source this file multiple times. Note: generally, I want access to applications installed using
# Homebrew first. It installs in /usr/local/bin.
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"

# Extend the path for user-install pip packages on mac
[[ -n $MAC ]] && PATH=$PATH:$HOME/Library/Python/3.7/bin

#
# Call other files
#
# If this file is called from a symlink, follow it; otherwise, get the current dir name.
# BASH_SOURCE is the name of the file that's currently being sourced.
[[ -n $(readlink $BASH_SOURCE) ]] && THIS_DIR=$(dirname $(readlink $BASH_SOURCE)) || THIS_DIR=$(dirname $BASH_SOURCE)
dprint $THIS_DIR
. $THIS_DIR/alias.sh
. $THIS_DIR/functions.sh

# Bash completion (for git)
[[ -f $(brew --prefix)/etc/bash_completion ]] && . $(brew --prefix)/etc/bash_completion

#
# Powerline clone
#
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go \
        -max-width 20 \
        -modules "nix-shell,user,ssh,cwd,jobs,exit,root" \
        -priority "root,cwd,user,host,ssh,perms,git-branch,git-status,hg,jobs,exit,cwd-path" \
        -error $?)"
}
[[ -n $MAC ]] && [[ -f "$GOBIN/powerline-go" ]] && PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

#
# Call user code
#
# If you have scripts that need to be sourced from your local system that cannot be committed to this repo,
# create a symlink here with the name local_bashrc.sh and have it point to the file you want to execute.
if [[ -f $THIS_DIR/local_bashrc.sh ]]; then
	dprint "Executing your local_bashrc.sh symlink"
	. $THIS_DIR/local_bashrc.sh
fi
