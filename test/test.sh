#!/bin/bash
set -euxo pipefail

IMG=myimg
# IMG=ubuntu:20.04
REPO=${REPO:-$(git rev-parse --show-toplevel)}
cd "$REPO"

docker build . -t mytestimg

# DUSER=youser
# docker run \
#   --rm \
#   --volume "$REPO:/home/$DUSER/.dotfiles" \
#   --env DUSER=$DUSER \
#   $IMG /home/youser/.dotfiles/test/test_impl.sh

#     # chown -R $DUSER:$DUSER /home/$DUSER/.dotfiles