FROM codercom/code-server:latest

SHELL ["/bin/bash", "-c"]
USER root

RUN apt-get update

#Install docker into workpace
RUN apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"
RUN apt-get update; \
    apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -aG docker coder

#Install docker-composer into workpace
RUN curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
    chmod +x /usr/local/bin/docker-compose; \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

USER coder
#Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash; \
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"; \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \
    nvm install 12; \
    nodepath=$(which node); sudo ln -s $nodepath /usr/bin/node

RUN echo 'alias ll="ls -al"' >> ~/.bashrc
ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]