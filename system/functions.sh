prune_docker_images()
{
    docker images | egrep '((weeks)|(months))\sago' | awk '{print $3}' | xargs docker rmi
}

# Improved version of 'watch'
watsch ()
{
    ls "$1" | entr sh -c 'clear; cat "$0"' $1
}

# Check out a PR post-merge
git_checkout_pr()
{
    git fetch origin refs/pull-requests/$1/merge && git checkout FETCH_HEAD && git submodule update
}

# Do an incremental editor build for unreal (hot reload)
unrealbuild() {
    UNR_PATH=$HOME/work/unrealengine;
    RANDNUM=$(( ( RANDOM % 1000 ) + 1000 ));
    CURR_DIR=`pwd`;
    PROJ_NAME=$(basename ${1%.uproject});

    ${UNR_PATH}/Engine/Build/BatchFiles/Linux/RunMono.sh ${UNR_PATH}/Engine/Binaries/DotNET/UnrealBuildTool.exe $PROJ_NAME -Module=$PROJ_NAME $RANDNUM Linux Debug -editorrecompile -canskiplink "${CURR_DIR}/${PROJ_NAME}.uproject" -progress
}
