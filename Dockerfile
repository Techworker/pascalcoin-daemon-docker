FROM debian:jessie
MAINTAINER techworker

ARG PASCAL_VERSION=3.0.1


# install wget supervisor and nano editor (debug)
RUN  apt-get update \
  && apt-get install -y wget supervisor nano \
  && rm -rf /var/lib/apt/lists/*

# add "pascal" user
RUN useradd -ms /bin/bash pascal
RUN echo 'pascal:pascal' | chpasswd

# init supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# change user
USER pascal
WORKDIR /home/pascal

# copy daemon file that starts the service
COPY daemon.sh /home/pascal/daemon.sh

# download build
RUN wget https://github.com/PascalCoin/PascalCoin/releases/download/${PASCAL_VERSION}/PascalCoin_${PASCAL_VERSION}_Ubuntu_16.04_64b_Binaries.tar.gz
RUN tar -xzf PascalCoin_${PASCAL_VERSION}_Ubuntu_16.04_64b_Binaries.tar.gz

# open up the RPC server
RUN sed -i "s|RPC_WHITELIST=127.0.0.1;|RPC_WHITELIST=|g" /home/pascal/PascalCoin_${PASCAL_VERSION}_Ubuntu_16.04_64b_Binaries/pascalcoin_daemon.ini

# create data directory
RUN mkdir /home/pascal/PascalCoin

USER root
CMD ["/usr/bin/supervisord"]
