#!/usr/bin/env bash
set -euo pipefail

# Note: this WILL delete files if you had any in these places
[[ ! -f ~/.gitconfig ]] && {
	touch ~/.gitconfig
}
prefix="# Include sensible defaults
[include]
    path = .dotfiles/applications/git/.gitconfig"
prepend ~/.gitconfig "$prefix"

# Assume we don't have a .gitexcludes yet
ln -sf "$DOTFILES/applications/git/.gitexcludes" "$HOME/.gitexcludes"