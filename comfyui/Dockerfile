ARG base_image

FROM ${base_image}

ARG comfyui_version
ARG cuda_version

# Install packages
RUN apt update \
  && apt install -y git \
  && apt autoclean \
  && apt autoremove --purge \
  && rm -rf /var/lib/apt/lists

# Create non-root user
RUN useradd comfyui --create-home --shell /usr/sbin/nologin

WORKDIR /app

# Ensure created user can write to the working directory
RUN chown -R comfyui:comfyui /app

# Switch to user
USER comfyui

# Clone the only the specific tag of ComfyUI repository
RUN git clone --branch ${comfyui_version} --depth 1 https://github.com/Comfy-Org/ComfyUI.git

# Change directory to the ComfyUI folder
WORKDIR /app/ComfyUI

# Install NVIDIA GPU Dependencies
RUN pip install --no-cache-dir torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/${cuda_version}

# Install ComfyUI dependencies
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8188

ENTRYPOINT ["python","/app/ComfyUI/main.py","--listen","0.0.0.0"]
