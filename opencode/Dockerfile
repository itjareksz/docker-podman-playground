ARG base_image

FROM ${base_image}

ARG opencode_version

# Install packages
RUN apt update \
  && apt install -y --no-install-recommends curl ca-certificates tini git xdg-utils

WORKDIR /projects

# Create non-root user and ensure created user can write to the working directory
RUN useradd opencode --create-home --shell /usr/sbin/nologin \
  && chown -R opencode:opencode /projects

# Switch to user, create required directories, and install OpenCode
USER opencode
RUN mkdir -p /home/opencode/.local/share/ \
  && mkdir -p /home/opencode/.local/state/ \
  && mkdir -p /home/opencode/.config/ \
  && curl -fsSL https://opencode.ai/install | bash -s -- --version ${opencode_version}

# PATH for ENTRYPOINT
ENV PATH="/home/opencode/.opencode/bin:$PATH"

# Remove packages and OpenCode installation file
USER root
RUN apt remove -y curl \
  && apt autoclean \
  && apt autoremove -y --purge \
  && rm -rf /var/lib/apt/lists

# Switch to user
USER opencode

ENTRYPOINT ["tini", "--", "opencode"]
