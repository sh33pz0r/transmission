FROM debian:jessie-slim

ENV DEBIAN_FRONTEND noninteractive
ENV GOSU_VERSION 1.7

RUN groupadd -r nas && useradd -r -g nas transmission \
    && apt-get -q update \
    && apt-get install -qy --force-yes transmission-daemon ca-certificates wget tar curl unrar-free procps \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get autoremove -y -qq && apt-get clean -qq \
    && rm -rf /var/lib/apt/lists/*

VOLUME ["/downloads", "/incomplete", "/config"]

COPY entrypoint.sh /entrypoint.sh
COPY settings.json /config/settings.json

EXPOSE 9091

CMD ["/entrypoint.sh"]
