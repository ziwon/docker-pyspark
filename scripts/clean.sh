#!/usr/bin/env bash

ORG="${ORG:-ziwon}"
NAME="${NAME:-docker-pyspark}"
IMAGE_NAME="$ORG/$NAME"

TAG="${TAG:-:latest}" && [ -n "$1" ] && TAG=:$1 && shift

echo ">> Cleaning containers..."
containers=`docker ps -qa --filter=ancestor=${IMAGE_NAME}${TAG} --filter=status=exited`
if [ -n "$containers" ]; then
    docker rm -f $containers
    echo "Cleaned."
else
    echo "No containers to clean: ${IMAGE_NAME}${TAG}"
fi

echo ">> Cleaning images..."
images=$(docker images --filter "dangling=true" -q)
if [ -n "$images" ]; then
    docker rmi -f $images
    echo "Cleaned."
else
    echo "No images to clean: ${IMAGE_NAME}${TAG}"
fi

[ ! $? -eq 0 ] && { echo "Error occured while cleaning: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."