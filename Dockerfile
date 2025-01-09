FROM codercom/code-server:latest
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN sudo apt-get update && sudo apt-get upgrade -y && \
    # install general dependencies
    sudo apt-get install -y --no-install-recommends g++ gcc make python3 zlib1g-dev && \

    # install Minimap2
    wget -qO- "https://github.com/lh3/minimap2/archive/refs/tags/v2.28.tar.gz" | tar -zx && \
    cd minimap2-* && \
    make && \
    chmod a+x minimap2 && \
    sudo mv minimap2 /usr/local/bin/minimap2 && \
    cd .. && \
    rm -rf minimap2-* && \

    # clean up
    sudo apt-get autoremove -y && \
    sudo apt-get purge -y --auto-remove && \
    sudo rm -rf /var/lib/apt/lists/*
