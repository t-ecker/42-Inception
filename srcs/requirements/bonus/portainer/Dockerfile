FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

#download portainer tar
RUN if [ ! -f "/portainer" ]; then \
    curl -L https://github.com/portainer/portainer/releases/download/2.18.1/portainer-2.18.1-linux-arm64.tar.gz -o portainer.tar.gz; \
    fi

COPY ./tools/entrypoint-script.sh /entrypoint-script.sh
RUN chmod +x ./entrypoint-script.sh

ENTRYPOINT ["/entrypoint-script.sh"]