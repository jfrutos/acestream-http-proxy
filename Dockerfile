# syntax=docker/dockerfile:1
FROM ubuntu:18.04

LABEL maintainer="Martin Bjeldbak Madsen <me@martinbjeldbak.com>"

ENV ACESTREAM_VERSION="3.1.75rc4_ubuntu_18.04_x86_64_py3.8"

RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    python3.8 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    libpython3.8-dev \
    libssl-dev \
    swig \
    libffi-dev \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN python3.8 -m pip install --no-cache-dir certifi PyNaCl pycryptodome apsw lxml

RUN wget --progress=dot:giga "https://download.acestream.media/linux/acestream_${ACESTREAM_VERSION}.tar.gz" && \
    mkdir acestream && \
    tar zxf "acestream_${ACESTREAM_VERSION}.tar.gz" -C acestream && \
    mv acestream /opt/acestream

# Document that we are exposing this as the HTTP API port
EXPOSE 6878/tcp

ENTRYPOINT ["/opt/acestream/start-engine"]
CMD ["--client-console"]
