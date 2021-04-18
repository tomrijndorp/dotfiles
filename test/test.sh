#!/bin/bash
set -euxo pipefail

REPO=${REPO:-$(git rev-parse --show-toplevel)}
cd "$REPO"

docker build .