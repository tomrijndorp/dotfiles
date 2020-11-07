#!/bin/bash
# Note that if you call these from a subshell, you may not have access to them if they weren't
# sourced explicitly. Consider creating a script in bin instead.

prune_docker_images()
{
    docker images | grep -E '((weeks)|(months))\sago' | awk '{print $3}' | xargs docker rmi
}

# Improved version of 'watch'
watsch ()
{
    # shellcheck disable=SC2016
    find . -name "$1" | entr sh -c 'clear; cat "$0"' "$1"
}

# Check out a PR post-merge
git_checkout_pr()
{
    git fetch origin refs/pull-requests/"$1"/merge && git checkout FETCH_HEAD && git submodule update
}

# copy commit of HEAD to clipboard
git_head_commit_copy()
{
    echo $(g log) | head -n1 | awk '{print $2}' | xclip
    # also print as confirmation
    xclip -o
}

# Do an incremental editor build for unreal (hot reload)
unrealbuild() {
    UNR_PATH=$HOME/work/unrealengine;
    RANDNUM=$(( ( RANDOM % 1000 ) + 1000 ));
    CURR_DIR=$(pwd);
    PROJ_NAME=$(basename "${1%.uproject}");

    "${UNR_PATH}/Engine/Build/BatchFiles/Linux/RunMono.sh" \
        "${UNR_PATH}/Engine/Binaries/DotNET/UnrealBuildTool.exe" \
        "$PROJ_NAME" \
        -Module="$PROJ_NAME" $RANDNUM Linux Debug -editorrecompile -canskiplink "${CURR_DIR}/${PROJ_NAME}.uproject" -progress
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alert()
# {
# 	notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"
# }

# To keep $PATH from growing and growing, initialize it here using the default Linux Ubuntu path
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.local/bin

wip()
{
#    git clang-format -f
    git add -u
    git commit -m "wip"
}

show_bazel_deps()
{
    xdot <(bazel query --notool_deps --noimplicit_deps "deps($1)" \
  --output graph)
}

show_bazel_deps_text()
{
    bazel query --notool_deps --noimplicit_deps "deps($1)" \
  --output graph
}

# Do an incremental editor build for unreal (hot reload) -- on OSX
unrealbuild_osx() {
    UNR_PATH='/Users/Shared/Epic Games/UE_4.21/'
    MONO="$UNR_PATH/Engine/Binaries/ThirdParty/Mono/Mac/bin/mono"
    UBT="$UNR_PATH/Engine/Binaries/DotNET/UnrealBuildTool.exe"
    # RANDNUM=$(( ( RANDOM % 1000 ) + 1000 ))
    RANDNUM=42  # I don't think it matters
    CURR_DIR=`pwd`
    PROJ_NAME=$(basename ${1%.uproject})

    $MONO $UBT -ModuleWithSuffix=$PROJ_NAME,$RANDNUM Mac Development -TargetType=Editor -Project="$1" -canskiplink "$1"

    # ${UNR_PATH}/Engine/Build/BatchFiles/Linux/RunMono.sh ${UNR_PATH}/Engine/Binaries/DotNET/UnrealBuildTool.exe $PROJ_NAME -Module=$PROJ_NAME $RANDNUM Linux Debug -editorrecompile -canskiplink "${CURR_DIR}/${PROJ_NAME}.uproject" -progress
}
