#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

# Base image version, get current version from https://hub.docker.com/_/debian
base_image="debian:trixie-20260713-slim"
# OpenCode version, get current version from https://github.com/anomalyco/opencode/releases
opencode_version="1.18.11"

podman build \
  --build-arg base_image=${base_image} \
  --build-arg opencode_version=${opencode_version} \
  -t opencode:${opencode_version} \
  -f ./Dockerfile
