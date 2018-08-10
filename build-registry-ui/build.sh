#!/bin/bash
# Version 1.0

DIRECTORY="$(cd "$(dirname "$0")" && pwd)"
cd "$DIRECTORY" || exit

source ../env.sh

# Registry is empty to use docker hub
REGISTRY_FROM=
IMAGE_FROM=$IMAGE_REGISTRY_UI
TAG_FROM=$TAG_REGISTRY_UI

REGISTRY_TO=$REGISTRY
IMAGE_TO=$IMAGE_REGISTRY_UI
TAG_TO=$TAG_REGISTRY_UI

REGISTRY_LOGIN="user"
REGISTRY_PASSWORD="password"

source ../build/function.sh

buildImage