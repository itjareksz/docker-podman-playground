#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

# Load values from .env file if it exists - it should contain path to projects directory
if [ -f ".env" ]; then
  # shellcheck source=.env
  source .env
else
  echo "Error: File .env does not exist. Use env.example to create .env file." >&2
  exit 1
fi

if [ -z "${projects_dir}" ]; then
  echo "Error: projects_dir is not defined in .env file." >&2
  exit 1
fi

if [ ! -d "${projects_dir}" ]; then
  echo "Error: Projects directory does not exist: ${projects_dir}" >&2
  exit 1
fi

app="opencode"

# Find and assign version from 01_podman-build.sh to a variable
# - -F'=' - separate at = character
# - gsub() - remove double or single quotes
# - printf() - don't print new line
opencode_version=$(awk -F'=' '/^opencode_version=/{gsub(/["'\'']/, "", $2); printf "%s", $2}' ./01_podman-build.sh)

echo "Creating container from image: localhost/${app}:${opencode_version}"

podman run -d \
  --name ${app} \
  --replace \
  --userns=keep-id:uid=1000,gid=1000 \
  -v "${HOME}/opencode/config/opencode.json:/home/opencode/.config/opencode/opencode.json:z" \
  -v "${HOME}/opencode/local/share:/home/opencode/.local/share/opencode:z" \
  -v "${HOME}/opencode/local/state:/home/opencode/.local/state/opencode:z" \
  -v "${projects_dir}:/projects:z" \
  --tz Europe/Warsaw \
  -p 127.0.0.1:4096:4096 \
  --cap-drop=ALL \
  --security-opt no-new-privileges \
  --pids-limit=100 \
  localhost/${app}:"${opencode_version}" \
  web --port 4096 --hostname 0.0.0.0

# --replace - if another container with the same name already exists, replace and remove it
#
#
# --userns=keep-id:uid=1000,gid=1000 - map host user to specified UID and GID within container;
#                                      opencode user created inside image gets this UID and GID;
#                                      needed for proper permissions of mounted volumes
#
# -v (...):z - z label needed for operating systems using SELinux;
#              z option tells Podman that two or more containers share the volume content
#              https://docs.podman.io/en/latest/markdown/podman-run.1.html#volume-v-source-volume-host-dir-container-dir-options
#
# -p 127.0.0.1:4096:4096 - restrict container network access to local machine
#
# --cap-drop, --security-opt, --pids-limit - options to harden container
