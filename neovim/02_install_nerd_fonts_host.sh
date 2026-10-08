#!/bin/bash

set -euo pipefail
# Uncomment for debug
# set -x

echo "Installing Symbols Nerd Font on host to render symbols properly in terminal used by Neovim plugins"

nerd_font_version="v3.5.1"

mkdir -p ${HOME}/.fonts
curl -fsSL -o ${HOME}/.fonts/NerdFontsSymbolsOnly.zip https://github.com/ryanoasis/nerd-fonts/releases/download/${nerd_font_version}/NerdFontsSymbolsOnly.zip
unzip -q -d ${HOME}/.fonts/NerdFontsSymbolsOnly/ ${HOME}/.fonts/NerdFontsSymbolsOnly.zip
rm ${HOME}/.fonts/NerdFontsSymbolsOnly.zip

echo "Font installed in path: ${HOME}/.fonts"
