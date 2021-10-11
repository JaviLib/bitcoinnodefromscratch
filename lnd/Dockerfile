FROM        debian
MAINTAINER  Javier "hub.docker@javi.space"

RUN apt-get update && \
    apt-get install -y git wget make expect && \
    apt-get clean

WORKDIR /tmp


#RUN wget -c https://github.com/lightningnetwork/lnd/releases/download/v0.13.1-beta/lnd-linux-amd64-v0.13.1-beta.tar.gz

RUN wget -c https://github.com/lightningnetwork/lnd/releases/download/v0.13.3-beta/lnd-linux-amd64-v0.13.3-beta.tar.gz


RUN tar -xvzf lnd-*.tar.gz
RUN rm /tmp/lnd-*.gz
RUN mv lnd-*/* /usr/local/bin
RUN ls -la /usr/local/bin


# Expose port 80
EXPOSE 9732
EXPOSE 10009
EXPOSE 8080

VOLUME /lnd

RUN ln -s /lnd /root/.lnd

ADD start.sh /start.sh
     
#CMD ["/start.sh"]

ENV PASS xxx

# channel backups
# https://medium.com/@patricklemke95/how-to-backup-your-lightning-network-channels-170c995c157b
VOLUME /backup

ENTRYPOINT ["/start.sh"]
