#!/usr/bin/env bash
# set -euo pipefail
set -x

cd "$HOME"
git clone https://github.com/tomrijndorp/dotfiles.git .dotfiles
cd .dotfiles

# Source the entrypoint script so we have an environment with some features we know
. system/entrypoint.sh

ENTRYPOINT_FILE=$HOME/.dotfiles/system/entrypoint.sh

if [[ -n $MAC ]]; then
	PROFILE_FILE=$HOME/.bash_profile
	echo "May I make a backup of your .bash_profile and symlink ~/.bash_profile to "`
	    `"$ENTRYPOINT_FILE [y/N]?"
elif [[ -n $LINUX ]]; then
	PROFILE_FILE=$HOME/.bashrc
	echo "May I make a backup of your .bashrc and symlink ~/.bashrc to "`
	    `"$ENTRYPOINT_FILE [y/N]?"
fi
read -r PROMPT
if [[ $PROMPT == 'y' ]]; then
	[[ -f $PROFILE_FILE ]] && mv "$PROFILE_FILE"{,.backup}
	ln -s "$ENTRYPOINT_FILE" "$PROFILE_FILE"
	echo 'If you open a new terminal, it should have your environment.'
	# shellcheck disable=SC2016
	echo 'Check with e.g. echo $MAC; echo $LINUX'
else
	echo -e "Don't forget to add a line such as\n\tsource $ENTRYPOINT_FILE\nto your rc file."
fi

echo -e "\033[32mDone! If you want to install your default stuff, call\n"
[[ $PROMPT == 'y' ]] && echo -e ". $PROFILE_FILE" || echo -e ". $ENTRYPOINT_FILE"
echo -e "$HOME/.dotfiles/installers/install_all.sh\033[0m"