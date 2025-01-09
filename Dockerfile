FROM codercom/code-server:latest
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>
RUN sudo apt-get update && sudo apt-get upgrade -y && \
    # install general dependencies
    sudo apt-get install -y --no-install-recommends bzip2 libbz2-dev libcurl4-openssl-dev liblzma-dev g++ gcc make python3 zlib1g-dev && \

    # install htslib
    wget -qO- "https://github.com/samtools/htslib/releases/download/1.20/htslib-1.20.tar.bz2" | tar -xj && \
    cd htslib-* && \
    ./configure && \
    make && \
    sudo make install && \
    cd .. && \
    rm -rf htslib-* && \

    # install Bowtie2
    wget -qO- "https://github.com/BenLangmead/bowtie2/archive/refs/tags/v2.5.4.tar.gz" | tar -zx && \
    cd bowtie2-* && \
    make && \
    sudo make install && \
    cd .. && \
    rm -rf bowtie2-* && \

    # install BWA
    wget -qO- "https://github.com/lh3/bwa/archive/refs/tags/v0.7.18.tar.gz" | tar -zx && \
    cd bwa-* && \
    make && \
    sudo mv bwa /usr/local/bin/bwa && \
    cd .. && \
    rm -rf bwa-* && \

    # install FastTree
    wget "http://www.microbesonline.org/fasttree/FastTree.c" && \
    gcc -DUSE_DOUBLE -DOPENMP -fopenmp -O3 -finline-functions -funroll-loops -Wall -o FastTree FastTree.c -lm && \
    sudo mv FastTree /usr/local/bin && \
    rm FastTree.c && \

    # install MAFFT
    wget -qO- "https://mafft.cbrc.jp/alignment/software/mafft-7.525-without-extensions-src.tgz" | tar -zx && \
    cd mafft-*/core && \
    make clean && \
    make && \
    sudo make install && \
    cd ../.. && \
    rm -rf mafft-* && \

    # install Minimap2
    wget -qO- "https://github.com/lh3/minimap2/archive/refs/tags/v2.28.tar.gz" | tar -zx && \
    cd minimap2-* && \
    make && \
    chmod a+x minimap2 && \
    sudo mv minimap2 /usr/local/bin/minimap2 && \
    cd .. && \
    rm -rf minimap2-* && \

    # install ViralConsensus
    wget -qO- "https://github.com/niemasd/ViralConsensus/archive/refs/tags/0.0.6.tar.gz" | tar -zx && \
    cd ViralConsensus-* && \
    make && \
    sudo mv viral_consensus /usr/local/bin/viral_consensus && \
    cd .. && \
    rm -rf ViralConsensus-* && \

    # install ViralMSA
    sudo wget -O /usr/local/bin/ViralMSA.py "https://github.com/niemasd/ViralMSA/releases/download/1.1.44/ViralMSA.py" && \
    sudo chmod a+x /usr/local/bin/ViralMSA.py && \

    # clean up
    sudo apt-get autoremove -y && \
    sudo apt-get purge -y --auto-remove && \
    sudo rm -rf /var/lib/apt/lists/*
