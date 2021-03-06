FROM ubuntu:latest
MAINTAINER techworker

ARG PASCAL_CHECKOUT=master
ARG SPHERE10=false
ARG OPENSSL_VERSION=1.1.0h
ARG CRYPRO_VERSION=1.1

# install wget fpc lazarus and nano editor (debug)
RUN  apt-get update \
  && apt-get install -y wget nano fp-compiler unzip lazarus git \
  && rm -rf /var/lib/apt/lists/*

# add "pascal" user
RUN useradd -ms /bin/bash pascal
RUN echo 'pascal:pascal' | chpasswd

# change user
USER pascal
WORKDIR /home/pascal

RUN mkdir pascalcoin_bin

# copy daemon file that starts the service
COPY daemon.sh /home/pascal/daemon.sh

# clone pascalcoin
RUN if [ ${SPHERE10} = true ]; then \
    git clone https://github.com/Sphere10/PascalCoin.git pascal_src
;fi

RUN if [ ${SPHERE10} = false ]; then \
    git clone https://github.com/PascalCoin/PascalCoin.git pascal_src
;fi

WORKDIR /home/pascal/pascal_src/src
RUN git checkout ${PASCAL_CHECKOUT}

# compile it and copy the build
RUN fpc -Fucore -Fulibraries/synapse -Fulibraries/pascalcoin -Tlinux -O- -opascalcoin_daemon pascalcoin_daemon.pp
RUN cp pascalcoin_daemon /home/pascal/pascalcoin_bin

WORKDIR /home/pascal

# download OPENSSL
RUN wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
RUN tar -xzf openssl-${OPENSSL_VERSION}.tar.gz

# compile libcrypto
WORKDIR /home/pascal/openssl-${OPENSSL_VERSION}

RUN mkdir tmp_openssl
RUN ./config shared --prefix=/home/pascal/openssl-${OPENSSL_VERSION}/tmp_openssl
RUN make install

# copy build
RUN cp tmp_openssl/lib/libcrypto.so.${CRYPRO_VERSION} /home/pascal/pascalcoin_bin

WORKDIR /home/pascal

# create data directory
RUN mkdir /home/pascal/PascalCoin
#RUN mkdir /home/pascal/PascalCoin/Data
RUN mkdir /home/pascal/PascalCoin_TESTNET

#RUN wget https://github.com/PascalCoin/PascalCoin/releases/download/2.1.9/BlockChainStream_196623.zip
#RUN unzip BlockChainStream_196623.zip -d /home/pascal/PascalCoin/Data

USER root

#COPY pascalcoin_daemon.ini /home/pascal/pascalcoin_bin/pascalcoin_daemon.ini
#RUN chown pascal:pascal /home/pascal/pascalcoin_bin/pascalcoin_daemon.ini

USER pascal

CMD ["/home/pascal/daemon.sh"]