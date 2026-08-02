#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

# Find and assign comfyui version from 01_podman-build.sh to a variable
# - -F'=' - separate at = character
# - gsub() - remove double or single quotes
# - printf() - don't print new line
comfyui_version=$(awk -F'=' '/^comfyui_version=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./01_podman-build.sh)

echo "Creating container from image: localhost/comfyui:${comfyui_version}"

podman run -d \
  --name comfyui \
  --replace \
  --userns=keep-id:uid=1000,gid=1000 \
  -v "${HOME}/comfyui/models:/app/ComfyUI/models:z" \
  -v "${HOME}/comfyui/output:/app/ComfyUI/output:z" \
  -v "${HOME}/comfyui/user:/app/ComfyUI/user:z" \
  -v "${HOME}/comfyui/custom_nodes:/app/ComfyUI/custom_nodes:z" \
  --tz Europe/Warsaw \
  -p 127.0.0.1:8188:8188 \
  --cap-drop=ALL \
  --security-opt no-new-privileges \
  --pids-limit=100 \
  --device nvidia.com/gpu=all \
  localhost/comfyui:"${comfyui_version}"

# --replace - if another container with the same name already exists, replace and remove it
#
#
# --userns=keep-id:uid=1000,gid=1000 - map host user to specified UID and GID within container;
#                                      comfyui user created inside image gets this UID and GID;
#                                      needed for proper permissions of mounted volumes
#
# -v (...):z - z label needed for operating systems using SELinux;
#              z option tells Podman that two or more containers share the volume content
#              https://docs.podman.io/en/latest/markdown/podman-run.1.html#volume-v-source-volume-host-dir-container-dir-options
#
# -p 127.0.0.1:8188:8188 - restrict container network access to local machine
#
# --cap-drop, --security-opt, --pids-limit - options to harden container
#
# Paths:
# - /comfyui/models - models
# - /comfyui/output - output images
# - /comfyui/user - user settings (e.g. saved workflows)
# - /comfyui/custom_nodes - custom nodes
