ARG base_image="debian:trixie-20260918-slim"

FROM ${base_image}

# Install packages
# ansible ansible-lint - needed by ansible-language-server
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git curl ca-certificates \
    fzf ripgrep fd-find \
    man-db tree unzip \
    ansible ansible-lint \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

# Install Neovim
ARG neovim_version="v0.12.5"
RUN curl -fsSL -o "/opt/neovim.tar.gz" https://github.com/neovim/neovim/releases/download/${neovim_version}/nvim-linux-x86_64.tar.gz \
  && tar -xzf "/opt/neovim.tar.gz" -C "/opt/" \
  && rm "/opt/neovim.tar.gz"

# Install Node.js with NPM
ARG node_version="v24.21.0"
RUN curl -fsSL -o "/opt/node.tar.gz" https://nodejs.org/dist/${node_version}/node-${node_version}-linux-x64.tar.gz \
  && tar -xzf "/opt/node.tar.gz" -C "/opt/" \
  && rm "/opt/node.tar.gz"

# Create non-root user and switch to user
ARG username="neovim"
WORKDIR /project
RUN useradd ${username} --uid 1000 --create-home --shell /usr/sbin/nologin \
  && chown -R ${username}:${username} /project
USER ${username}

# Create directories for used applications
ENV PATH="/opt/nvim-linux-x86_64/bin:/opt/node-${node_version}-linux-x64/bin:/home/${username}/.local/bin:/home/${username}/.npm-global/bin:${PATH}"
RUN mkdir -p ${HOME}/.config/nvim \
  && mkdir -p ${HOME}/.local/bin  \
  && mkdir -p ${HOME}/.npm-global \
  && npm config set prefix '~/.npm-global'

# Install LSP, Linters, Formatters

# --- Bash LSP ---
ARG bash_lsp_version="5.8.1"
RUN npm install -g bash-language-server@${bash_lsp_version}
# --- Bash linter---
ARG shellcheck_version="v0.11.0"
RUN curl -fsSL -o "/tmp/shellcheck.tar.gz" https://github.com/koalaman/shellcheck/releases/download/${shellcheck_version}/shellcheck-${shellcheck_version}.linux.x86_64.tar.gz \
  && tar -xzf "/tmp/shellcheck.tar.gz" -C /tmp/ \
  && cp "/tmp/shellcheck-${shellcheck_version}/shellcheck" "${HOME}/.local/bin/" \
  && chmod 700 "${HOME}/.local/bin/shellcheck" \
  && rm -r "/tmp/shellcheck-${shellcheck_version}/"
# --- Bash formatter ---
ARG shfmt_version="v3.14.1"
RUN curl -fsSL -o "${HOME}/.local/bin/shfmt" https://github.com/mvdan/sh/releases/download/${shfmt_version}/shfmt_${shfmt_version}_linux_amd64 \
  && chmod 700 "${HOME}/.local/bin/shfmt"

# --- Ansible LSP ---
ARG ansible_lsp_version="26.6.0"
RUN npm install -g @ansible/ansible-language-server@${ansible_lsp_version}

# --- YAML LSP, formatter ---
ARG yaml_lsp_version="1.24.0"
RUN npm install -g yaml-language-server@${yaml_lsp_version}

# --- Markdown LSP ---
ARG markdown_oxide_version="v0.25.12"
RUN curl -fsSL -o "${HOME}/.local/bin/markdown-oxide" https://github.com/Feel-ix-343/markdown-oxide/releases/download/${markdown_oxide_version}/markdown-oxide-${markdown_oxide_version}-x86_64-unknown-linux-gnu \
  && chmod 700 "${HOME}/.local/bin/markdown-oxide"
# --- Markdown, JavaScript, JSON, HTML, CSS formatter ---
ARG prettier_version="3.9.9"
RUN npm install -g prettier@${prettier_version}

# --- Dockerfile LSP ---
ARG dockerfile_lsp_version="0.15.0"
RUN npm install -g dockerfile-language-server-nodejs@${dockerfile_lsp_version}
# --- Dockerfile linter ---
ARG hadolint_version="v2.15.1"
RUN curl -fsSL -o "${HOME}/.local/bin/hadolint" https://github.com/hadolint/hadolint/releases/download/${hadolint_version}/hadolint-linux-x86_64 \
  && chmod 700 "${HOME}/.local/bin/hadolint"

# Set bash aliases
RUN printf "\nalias ll='ls -lah --color=auto'" >> ${HOME}/.bashrc \
  && printf "\nalias grep='grep --color=auto'" >> ${HOME}/.bashrc

# Copy Neovim configuration
COPY ./config/init.lua /home/${username}/.config/nvim/

# Run Neovim in headless mode to install packages from init.lua
RUN /opt/nvim-linux-x86_64/bin/nvim --headless +qa

ENTRYPOINT ["nvim"]
# ENTRYPOINT ["bash"]
