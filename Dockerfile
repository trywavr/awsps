FROM ubuntu:16.04

RUN ldd --version

RUN apt-get update

RUN apt-get -y install locales

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN apt-get install -y git curl

RUN curl -sSL https://get.haskellstack.org/ | sh

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

RUN ls /root/.local/bin