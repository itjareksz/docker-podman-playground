#!/bin/bash

set -eu -o pipefail
# Uncomment for debug
# set -x

mkdir -p "${HOME}/comfyui/models"
mkdir -p "${HOME}/comfyui/output"
mkdir -p "${HOME}/comfyui/user"
mkdir -p "${HOME}/comfyui/custom_nodes"

models_subdirs=(
  audio_encoders
  background_removal
  checkpoints
  clip
  clip_vision
  configs
  controlnet
  detection
  diffusers
  diffusion_models
  embeddings
  frame_interpolation
  geometry_estimation
  gligen
  hypernetworks
  latent_upscale_models
  loras
  model_patches
  optical_flow
  photomaker
  style_models
  text_encoders
  unet
  upscale_models
  vae
  vae_approx
)

for dir in "${models_subdirs[@]}"; do
  mkdir -p "${HOME}/comfyui/models/${dir}"
done
