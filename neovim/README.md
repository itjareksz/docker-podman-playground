# Neovim in a container

## Description

Files in this directory allow to create Neovim image with my custom configuration. Then when creating container you can mount project directory to edit files.

Inside image following tools are installed:

- Neovim
- Node.js & NPM (needed by many Language Server Providers)
- LSPs
- Linters
- Formatters

I created this image to evaluate if Neovim can be a good editor for my homelab coding needs.

Scripts use Podman to build image and run container.

## Usage

Neovim configuration is in file `/config/init.lua`. Here you can add/remove Neovim options. When building image this file is copied to image.

Run scripts in sequence:

- `01_podman-build.sh` - build image
- `02_install_nerd_fonts_host.sh` - download Symbols Nerd Font to user's `~/.fonts` directory. Font is used by Neovim plugins to render icons. This font is needed in a terminal in which you are running scripts, not in a container.
- `03_podman-run.sh <directory>` - pass directory as an argument. This directory will be mounted inside container and will be opened with Neovim.
