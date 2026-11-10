#!/bin/bash

set -euo pipefail
# Uncomment for debug
# set -x

image_version=$(awk -F'=' '/^ARG image_version=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./Dockerfile)
image_name=$(awk -F'=' '/^ARG image_name=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./Dockerfile)

podman build \
  -t "${image_name}:${image_version}" \
  -f ./Dockerfile
