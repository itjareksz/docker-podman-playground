#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

# Base image version, get current version from https://hub.docker.com/_/debian
base_image="debian:trixie-20261104-slim"
# OpenCode version, get current version from https://github.com/anomalyco/opencode/releases
opencode_version="2.2.7"

podman build \
  --build-arg base_image=${base_image} \
  --build-arg opencode_version=${opencode_version} \
  -t opencode:${opencode_version} \
  -f ./Dockerfile
