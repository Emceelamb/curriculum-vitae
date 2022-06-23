FROM ubuntu:21.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -y -qq --no-install-recommends \
        ca-certificates  \
        curl \
        ghostscript \
        git \
        gnuplot \
        imagemagick \
        make \
        jq \
        qpdf \
        python3-pygments \
        wget \
        vim-tiny && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /texlive

COPY install-texlive.sh .
COPY texlive.profile .

RUN chmod +x install-texlive.sh && \
    ./install-texlive.sh

RUN apt update 
RUN apt install pandoc -y

COPY ./content.md .
COPY ./template.tex .

COPY ./fonts /usr/share/fonts
RUN fc-cache -f -v

WORKDIR /data

VOLUME ["/data"]
