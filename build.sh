#!/bin/bash
# v1.0

DIRECTORY="$(cd "$(dirname "$0")" && pwd)"
cd "$DIRECTORY"

set -e

source ./env.sh

./build-registry/build.sh
./build-registry-ui/build.sh