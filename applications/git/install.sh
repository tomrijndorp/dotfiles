#!/usr/bin/env bash
set -euo pipefail

# Note: this WILL delete files if you had any in these places
ln -sf $DOTFILES/applications/git/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/applications/git/.gitexcludes $HOME/.gitexcludes