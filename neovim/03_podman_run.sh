#!/bin/bash

set -euo pipefail
# Uncomment for debug
# set -x

# =========================================================
# Only allow directory as argument
# =========================================================

# Check if correct number of arguments is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 </path/to/directory>"
  echo "Got $# arguments"
  exit 1
fi

# Convert directory path to absolute path
project_dir=$(realpath "${1}")

if [[ ! -d "${project_dir}" ]]; then
  echo "Error: '${project_dir}' is not a directory."
  exit 1
fi

# =========================================================
# Run container
# =========================================================

# Find and assign image version from 01_podman-build.sh to a variable
# - -F'=' - separate at = character
# - gsub() - remove double or single quotes
# - printf() - don't print new line
image_version=$(awk -F'=' '/^image_version=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./01_podman-build.sh)
image_name=$(awk -F'=' '/^image_name=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./01_podman-build.sh)

echo "Creating container from image: localhost/${image_name}:${image_version}"

podman run -it --rm \
  --name ${image_name} \
  --replace \
  --userns=keep-id:uid=1000,gid=1000 \
  -v "${project_dir}:/project:z" \
  --tz Europe/Warsaw \
  --cap-drop=ALL \
  --security-opt no-new-privileges \
  --security-opt label=disable \
  --pids-limit=100 \
  "localhost/${image_name}:${image_version}"

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
# --cap-drop, --security-opt, --pids-limit - options to harden container
#
# --security-opt label=disable - disable SELinux separation for the container,
#                                used when mounted volume on host is on a filesystem that doesn't support SELinux labels (like shared filesystem in VM)
