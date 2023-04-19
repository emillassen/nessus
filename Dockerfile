FROM ubuntu:23.04

LABEL maintainer="emillassen"

ADD config /tmp/

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y \
    apt-utils \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8834

VOLUME ["/config"]

ENTRYPOINT ["/bin/bash", "/tmp/setup.sh"]
