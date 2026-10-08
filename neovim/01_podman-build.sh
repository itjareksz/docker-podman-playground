#!/bin/bash

set -euo pipefail
# Uncomment for debug
# set -x

image_version="0.1.0"
image_name="neovim"

podman build \
  -t "${image_name}:${image_version}" \
  -f ./Dockerfile
