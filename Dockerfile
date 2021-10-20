FROM amazonlinux:2.0.20191217.0

SHELL ["/bin/bash", "--rcfile", "~/.profile", "-c"]

################################
#### Switching to root user
################################

USER root

# Saving default system libraries before doing anything else
RUN du -a /lib64 /usr/lib64 | cut -f2 > /root/default-libraries

# Installing basic dependencies
RUN yum install -y \
    git-core \
    tar \
    sudo \
    xz \
    make \
    gmp-devel \
    postgresql-devel \
    libicu libicu-devel \
    libyaml libyaml-devel

RUN yum groupinstall -y "Development Tools" "Development Libraries"

RUN sudo curl -sSL http://get.haskellstack.org/ | sh

RUN yum install git

RUN mkdir /project

WORKDIR /project

RUN git clone https://github.com/purescript/purescript

WORKDIR /project/purescript

RUN stack build

RUN stack install

WORKDIR /project

RUN git clone https://github.com/purescript/spago

WORKDIR /project/spago

RUN make

RUN make install

RUN which purs

RUN whereis purs

RUN which spago

RUN whereis spago