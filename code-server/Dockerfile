FROM codercom/code-server:latest AS install_docker
USER root

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"
# [Option] Enable non-root Docker access in container
ARG ENABLE_NONROOT_DOCKER="true"
# [Option] Use the OSS Moby Engine instead of the licensed Docker Engine
ARG USE_MOBY="true"

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=1000
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    # Use Docker script from script library to set things up
    && /bin/bash /tmp/library-scripts/docker-in-docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}"
    # Clean up
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/
VOLUME [ "/var/lib/docker" ]

FROM install_docker AS install_node
ARG USERNAME
ARG NODE_VERSION
USER $USERNAME
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash; \
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"; \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \
    nvm install $NODE_VERSION; \
    nodepath=$(which node); sudo ln -s $nodepath /usr/bin/node

FROM install_node AS start
WORKDIR ~/projects
ARG USERNAME
USER $USERNAME
SHELL ["/bin/bash", "-c"]
RUN echo 'alias ll="ls -al"' >> ~/.bashrc
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]
