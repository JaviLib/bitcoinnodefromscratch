# https://github.com/lightningnetwork/lnd/blob/master/docs/INSTALL.md

FROM        alpine
MAINTAINER  Javier "hub.docker@javi.space"

VOLUME /etc/tor
VOLUME /var/lib/tor

RUN apk update && apk upgrade && apk add tor privoxy bash

EXPOSE 1050
EXPOSE 1051
EXPOSE 9001
EXPOSE 8118


RUN echo "forward-socks5t / 127.0.0.1:9050 ." >> /etc/privoxy/config && \
    sed -i '/listen-address/d' /etc/privoxy/config && \
    echo "listen-address :8118" >> /etc/privoxy/config

ENV http_proxy=http://localhost:8118
ENV https_proxy=http://localhost:8118
ENV HTTP_PROXY=http://localhost:8118
ENV HTTPS_PROXY=http://localhost:8118

CMD privoxy /etc/privoxy/config && tor -f /etc/tor/torrc
