FROM codercom/code-server:latest

RUN apt update

#Install docker into workpace
RUN apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common \
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
RUN apt update \
    apt install -y docker-ce docker-ce-cli containerd.io \
    usermod -aG docker coder

#Install docker-composer into workpace
RUN curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    chmod +x /usr/local/bin/docker-compose \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "."]