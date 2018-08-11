#!/bin/bash

export REGISTRY="local"
echo $REGISTRY

export IMAGE_REGISTRY="registry"
export TAG_REGISTRY=2.6.2
echo $IMAGE_REGISTRY
echo $TAG_REGISTRY

export IMAGE_REGISTRY_UI="quiq/docker-registry-ui"
export TAG_REGISTRY_UI=0.7.2

echo $IMAGE_REGISTRY_UI
echo $TAG_REGISTRY_UI

export SERVICE=registry
echo $SERVICE
