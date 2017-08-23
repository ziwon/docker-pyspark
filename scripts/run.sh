#!/usr/bin/env bash
ORG="${ORG:-ziwon}"
NAME="${NAMGE:-docker-pyspark}"
IMAGE_NAME="$ORG/$NAME"

TAG="${TAG:-:latest}" && [ -n "$1" ] && TAG=:$1 && shift

echo ">> Running..."

APP_HOME="${APP_HOME:-/opt/app}"

CMD="docker run -v $(pwd)/examples:$APP_HOME -it ${IMAGE_NAME}${TAG} bash -c "$APP_HOME/ratings-counter.py" $@"
echo ">> $CMD" && $CMD

[ ! $? -eq 0 ] && { echo "Error occured while running: ${IMAGE_NAME}${TAG}"; exit 1; } || echo ">> Finished."
