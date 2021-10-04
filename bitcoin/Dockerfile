FROM        debian
MAINTAINER  Javier "hub.docker@javi.space"


RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

WORKDIR /tmp

#RUN wget -c https://bitcoincore.org/bin/bitcoin-core-0.21.0/bitcoin-0.21.0-x86_64-linux-gnu.tar.gz

RUN wget -c https://bitcoincore.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz

WORKDIR /usr/local

RUN tar xvfz /tmp/bitcoin*.tar.gz
RUN ln -s bitcoin-* bitcoin
ENV PATH=$PATH:/usr/local/bitcoin/bin
RUN echo New path: $PATH
RUN rm /tmp/bitcoin*.tar.gz

EXPOSE 8333
EXPOSE 8332
EXPOSE 28332

VOLUME /bitcoin

RUN ln -s /bitcoin /root/.bitcoin

#ADD start.sh /start.sh
     

ENTRYPOINT ["bitcoind"]
