FROM archlinux/base:latest

MAINTAINER Dima Chizhevsky <dima.chizhevsky@geoprotocol.io>

RUN pacman --noconfirm -Syu 
RUN pacman --noconfirm -S boost-libs
RUN pacman --noconfirm -S libsodium
RUN pacman --noconfirm -S htop # For development purposes only

VOLUME ["/node"]
COPY node/ /node/

WORKDIR /node/
ENTRYPOINT ["./entrypoint.sh"]
