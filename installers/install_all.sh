#!/usr/bin/env bash

set -euo pipefail

# Installer for a clean mac

# Note: expects that you have run your shell entrypoint script that contains stuff such as MAC, LINUX, dprint(), etc.

# Install homebrew
install_homebrew() {
    # Requires the XCode command line tools, but will install those automatically.
    # You may be asked for a password.
    if [[ -f /usr/local/bin/brew ]]; then
	dprint "Skipping Homebrew install"
    else
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

install_powerline_fonts() {
    dprint "Installing powerline fonts..."
    BACK=$(pwd)
    cd /tmp
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    cd $BACK
}

if [[ -n $MAC ]]; then
    install_homebrew
    install_powerline_fonts
    
    # Install some useful utilities
    # git goes before bash-completion
    brew install \
        git \
        golang \
        bash-completion \
        jupyter \
        htop \
        the_silver_searcher \
        tree \
        python3  # Automatically installs pip3 these days

    # Add path for user-installed Python packages
    export PATH=$PATH:$HOME/Library/Python/3.7/bin

    # Let's pimp the shell with a powershell fork (built in go, so reasonably fast)
    go get -u github.com/justjanne/powerline-go
    # Re-source
    . $DOTFILES/system/entrypoint.sh
    # Note: if the fonts don't seem to be working; you do need to set your terminal
    # application to use a powerline-patched font!
fi

if [[ -n $LINUX ]]; then
    /bin/true
fi

# Install python packages
pip3 install --user \
    numpy \
    bokeh
