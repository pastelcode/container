# Dockerfile
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install tools and Java
RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        libc6 \
        libc6-i386 \
        lib32z1 \
        lib32ncurses6 \
        bison \
        csh \
        libxaw7-dev \
        git \
        gcc \
        make \
        wget \
        unzip \
        default-jdk && \
        python3 \
        python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Install Jupiter
WORKDIR /opt
RUN wget https://github.com/andrescv/Jupiter/releases/download/v3.1/Jupiter-3.1-linux.zip && \
    unzip Jupiter-3.1-linux.zip && \
    mv image jupiter
ENV PATH="$PATH:/opt/jupiter/bin"

# Clone course material
RUN mkdir -p /usr/class && \
    git clone https://github.com/CC-4/compiladores2021.git /usr/class/cc4 && \
    ln -s /usr/class/cc4/cool /root/cool
ENV PATH="$PATH:/usr/class/cc4/cool/bin"

# RISC-V files and tools
WORKDIR /usr/class/cc4/bin
RUN rm -f coolc-rv.jar coolc-rv jupitercl && \
    wget https://github.com/CC-4/PA4/releases/download/v1.0/coolc-rv.jar && \
    wget https://github.com/CC-4/PA4/releases/download/v1.1/coolc-rv && \
    wget https://github.com/CC-4/PA4/releases/download/v1.1/jupitercl && \
    chmod +x coolc-rv jupitercl

WORKDIR /usr/class/cc4/lib
RUN rm -f runtime.s && \
    wget https://raw.githubusercontent.com/CC-4/runtime/master/runtime.s

# Trap handler workaround
WORKDIR /usr/class
RUN mkdir -p cs143/cool/lib && \
    cp ./cc4/cool/lib/trap.handler ./cs143/cool/lib

WORKDIR /workspace
CMD ["/bin/bash"]
