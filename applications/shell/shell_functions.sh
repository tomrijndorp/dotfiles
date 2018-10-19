#!/bin/sh

# Load aliases
. ~/.dotfiles/system/alias

# Load functions
. ~/.dotfiles/system/functions

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# To keep $PATH from growing and growing, initialize it here using the default Linux Ubuntu path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.local/bin

wip()
{
    git clang-format -f
    git add -u
    git commit -m "wip"
}

# Fix mouse scrolling to natural even after USB id changes
MOUSE_ID=$(xinput list --id-only 'Logitech M705' 2> /dev/null)
if [ ! -z $MOUSE_ID ]; then
#   echo 'changing mouse settings'
    PROP_NUM=$(xinput list-props $MOUSE_ID | grep -o 'Natural Scrolling Enabled (...)' | grep -o -E '[0-9]+')
    xinput set-prop $MOUSE_ID $PROP_NUM 1
fi

# Do an incremental editor build for unreal (hot reload)
function unrealbuild {
    UNR_PATH=$HOME/work/unrealengine;
    RANDNUM=$(( ( RANDOM % 1000 ) + 1000 ));
    CURR_DIR=`pwd`;
    PROJ_NAME=$(basename ${1%.uproject});

    ${UNR_PATH}/Engine/Build/BatchFiles/Linux/RunMono.sh ${UNR_PATH}/Engine/Binaries/DotNET/UnrealBuildTool.exe $PROJ_NAME -Module=$PROJ_NAME $RANDNUM Linux Debug -editorrecompile -canskiplink "${CURR_DIR}/${PROJ_NAME}.uproject" -progress
}

# keyboard repeat settings
xset r rate 200 25
