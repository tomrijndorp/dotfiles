#!/usr/bin/env bash

set -euo pipefail

# Installer for a clean mac / linux system

# Note: expects that you have run your shell entrypoint script that contains stuff such as MAC, LINUX, dprint(), etc.

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
    # Exit if we have powerline fonts already
    [[ -n $MAC ]] && ls ~/Library/Fonts/*powerline* > /dev/null && dprint "Skipping powerline font installation" && return 0
    [[ -n $LINUX ]] && return 0  # For linux, we just apt install fonts-powerline
    dprint "Installing powerline fonts..."
    BACK=$(pwd)
    cd /tmp
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    cd "$BACK"
}

install_powerline() {
    pip3 install --user \
        powerline-status \
        powerline-gitstatus
    ln -sf "$DOTFILES/config/powerline/" ~/.config
}

install_ohmyzsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

configure_vim() {
    ln -sf "$DOTFILES/config/vim/.vimrc" ~/.vimrc
}

install_sublime() {
    if [[ -n $LINUX ]]; then
        dprint "Installing sublime..."
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
        sudo apt-get update
        sudo apt-get install sublime-text
    fi
}

install_synergy() {
    if [[ -n $LINUX ]]; then
        dprint "Installing synergy..."
        TMP=mktemp
        curl https://symless.com/synergy/download/direct?platform=ubuntu\&architecture=x64 > $TMP
        sudo apt install -f $TMP
    fi
}

if [[ -n $MAC ]]; then
    install_homebrew
    install_powerline_fonts
    install_powerline
    install_ohmyzsh
    
    # Install some useful utilities
    # git goes before bash-completion
    brew install \
        git \
        golang \
        bash-completion \
        jupyter \
        htop \
        shellcheck \
        the_silver_searcher \
        tree \
        python3 \
        vim --with-python3

    # Add path for user-installed Python packages
    export PATH="$PATH:$HOME/Library/Python/3.7/bin"
fi

if [[ -n $LINUX ]]; then
    sudo apt install -y --no-install-recommends \
        apt-transport-https \
        curl \
        docker-ce \
        gdb \
        gitk \
        less \
        python3 \
        python3-pip \
        scons \
        shellcheck \
        vim-gtk3 \
        wget

    install_sublime
    install_synergy
fi

# Install python packages
pip3 install --user \
    bokeh \
    numpy \
    yamllint

# Re-source
. "$DOTFILES/system/entrypoint.sh"
# Note: if the fonts don't seem to be working; you do need to set your terminal
# application to use a powerline-patched font!
