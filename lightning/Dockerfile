# https://github.com/ElementsProject/lightning/blob/master/Dockerfile

FROM        ubuntu
MAINTAINER  Javier "hub.docker@javi.space"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt install -y software-properties-common
RUN add-apt-repository -u ppa:lightningnetwork/ppa
RUN apt-get install -y lightningd

# clboss
# https://github.com/ZmnSCPxj/clboss
RUN apt-get install -y  build-essential pkg-config libev-dev libcurl4-gnutls-dev libsqlite3-dev dnsutils git automake autoconf-archive libtool wget && \
    apt-get clean
WORKDIR /tmp
RUN git clone https://github.com/ZmnSCPxj/clboss
WORKDIR /tmp/clboss
RUN autoreconf -i
RUN ./configure && make -j7 && make install


#C-Lig Rest API
# https://github.com/Ride-The-Lightning/c-lightning-REST
# https://github.com/Ride-The-Lightning/c-lightning-REST/releases

WORKDIR /usr/local
RUN rm -rf /tmp/clboss
RUN apt install -y npm && apt-get clean
#RUN git clone https://github.com/saubyk/c-lighthing-REST
RUN git clone https://github.com/saubyk/c-lightning-REST
WORKDIR /usr/local/c-lightning-REST 
RUN npm install -g n
RUN n stable
RUN npm i npm@latest -g
RUN npm install
EXPOSE 3002
EXPOSE 4001

WORKDIR /


ADD bitcoin-cli /usr/bin/bitcoin-cli
ENTRYPOINT [ "/usr/bin/lightningd"]
