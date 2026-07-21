#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

# Base image version, get current version from https://hub.docker.com/_/python
# Check ComfyUI compatibility with Python version https://docs.comfy.org/installation/system_requirements#python-version
base_image="python:3.13-slim"
# ComfyUI version, get current version from https://github.com/Comfy-Org/ComfyUI/releases
comfyui_version="v0.28.0"
# CUDA version for PyTorch; get current version from https://pytorch.org/get-started/locally/
cuda_version="cu132"
# CUDA 12 (for older GPU)
#cuda_version="cu126"

podman build \
  --build-arg base_image=${base_image} \
  --build-arg comfyui_version=${comfyui_version} \
  --build-arg cuda_version=${cuda_version} \
  -t comfyui:${comfyui_version} \
  -f ./Dockerfile
