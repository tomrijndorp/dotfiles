# Common environment

#
# Set PATH
#
# We just re-set PATH here in case anybody messes with it, and such that we don't keep appending when
# we source this file multiple times. Note: generally, I want access to applications installed using
# Homebrew first. It installs in /usr/local/bin.
DEFAULT_PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$DOTFILES/system/bin:$HOME/applications
PATH=$DEFAULT_PATH

pathify() {
    cat $1 | awk '!/#/ {print}' | tr '\n' :
}

# prepend, append to PATH
PRE=
POST=
if [[ -f $DF_PATH_PRE_FILE ]]; then
    PRE=$(pathify "$DF_PATH_PRE_FILE")
fi
if [[ -f $DF_PATH_POST_FILE ]]; then
    POST=$(pathify "$DF_PATH_POST_FILE")
fi


# Environment for less; enable raw ANSI characters and case insensitive search
export LESS=-Ri

# Settings for FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_COMPLETION_TRIGGER='**'

# Settings for ripgrep
export RIPGREP_CONFIG_PATH=$DOTFILES/config/.ripgreprc

# Mac environment
[[ -n $MAC ]] && {
    # Extend the path for user-install pip packages on mac
    DEFAULT_PATH=$DEFAULT_PATH:$HOME/Library/Python/3.7/bin
}

# Linux environment
[[ -n $LINUX ]] && {
    PATH=$PATH:$HOME/.local/bin/
    # XDG_CONFIG_DIRS: Well-behaved applications will search these folders for configuration data
    # export XDG_CONFIG_DIRS=$DOTFILES/config:~/.config
}

# construct final path
PATH="$PRE$DEFAULT_PATH:$POST"

export PATH
#gprint "path is now $PATH"
