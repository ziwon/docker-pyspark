#!/usr/bin/env bash

ORG="${ORG:-ziwon}"
NAME="${NAME:-docker-pyspark}"
IMAGE_NAME="$ORG/$NAME"

TAG="${TAG:-:latest}" && [ -n "$1" ] && TAG=:$1 && shift

echo ">> Building..."

CMD="docker build -t ${IMAGE_NAME}${TAG} ."
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo "Error occured while building: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."