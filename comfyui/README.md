# ComfyUI

## About ComfyUI

**ComfyUI** is a node based AI tool for image generation and more (video, 3D models, audio, texts):

- Website https://www.comfy.org
- Repository https://github.com/Comfy-Org/ComfyUI

## NVIDIA GPU

Scripts are prepared for use with Nvidia GPU.

For ComfyUI container to have access to Nvidia GPU you need to install the [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).

## Usage

Run scripts in sequence:

- `01_podman-build.sh` - build image
- `02_create_directories.sh` - create local directories shared with container
- `03_podman-run.sh` - create container and expose ComfyUI on port `8188`

To update base image and libraries to new version change variables in `01_podman-build.sh`.

Enter address `http://localhost:8188` in your browser to use ComfyUI.
