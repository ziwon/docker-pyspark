#!/usr/bin/env bash

ORG="${ORG:-ziwon}"
NAME="${NAME:-docker-pyspark}"
IMAGE_NAME="$ORG/$NAME"

echo ">> Pushing..."

TAG="${TAG:-:latest}" && [ -n "$1" ] && TAG=:$1 && shift

CMD="docker push ${IMAGE_NAME}${TAG}"
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo "Error occured while pushing: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."