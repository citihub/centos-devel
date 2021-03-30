#!/usr/bin/env bash

set -eo pipefail

IMAGE_NAME="citihub/centos-devel:dev"

LATEST_NAME="citihub/centos-devel:latest"

# Lint Dockerfile
echo "Linting Dockerfile..."
docker run --rm -i hadolint/hadolint:v1.17.6-alpine < Dockerfile
echo "Lint Successful!"

# Build dev image
if [ -n "$1" ]; then
  TAG="$1"
  echo "Building release image with ${TAG}..."
  IMAGE_NAME="citihub/centos-devel:${TAG}"
  echo "Building release image ${IMAGE_NAME}..."
  docker image build -t $IMAGE_NAME .
  docker push ${IMAGE_NAME}
  docker tag ${IMAGE_NAME} ${LATEST_NAME}
  docker push ${LATEST_NAME}
else
  echo "Building dev images with default parameters..."
  docker image build -f Dockerfile -t $IMAGE_NAME .
fi

# Test dev image
echo "Executing container structure test..."
docker container run --rm -it -v "${PWD}"/tests/container-structure-tests.yml:/tests.yml:ro -v /var/run/docker.sock:/var/run/docker.sock:ro gcr.io/gcp-runtimes/container-structure-test:v1.8.0 test --image $IMAGE_NAME --config /tests.yml
