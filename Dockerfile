FROM openjdk:8-jdk-alpine AS java-base
RUN \
  apk add --no-cache bash

FROM java-base AS bash-installed
RUN echo '@testing http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk add --no-cache mongodb@testing
 
FROM bash-installed AS mongo-runner
ADD ./start_server.sh /usr/local/bin
ADD ./stop_server.sh /usr/local/bin
RUN mkdir -p /data/db
EXPOSE 27017
VOLUME ["/data/db"]

