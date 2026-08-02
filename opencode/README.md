# OpenCode

## About OpenCode

**OpenCode** is an AI coding agent:

- Website https://opencode.ai/
- Repository https://github.com/anomalyco/opencode
- Documentation https://opencode.ai/docs

## Description

Scripts use Podman and do the following:

- create OpenCode image based on Dockerfile
- create required directories on host
- run container with OpenCode web UI

## Usage

Run scripts in sequence:

- `01_podman-build.sh` - build image
- `02_create_directories.sh` - create local directories shared with container with simple `opencode.json` where custom configurations can be set
- `03_podman-run.sh` - create container
  - **IMPORTANT:** Set path to directory with projects (git repositories) mounted inside container by creating and editing `.env` file basing on `env.sample`.

Enter address `http://localhost:4096` in your browser to use OpenCode web UI.

**NOTE**  
To update base image and OpenCode to new version change variables in `01_podman-build.sh`.
