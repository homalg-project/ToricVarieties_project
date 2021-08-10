FROM gapsystem/gap-docker-master
MAINTAINER Kamal Saleh <kamal.saleh@uni-siegen.de>

USER root

RUN apt-get update && apt-get install python3-pip -y

RUN apt-get install 4ti2

RUN cd /home/gap/inst/gap-master/pkg \
    && git clone https://github.com/kamalsaleh/CddInterface \
    && cd CddInterface \
    && ./install.sh ../.. \
    && cd .. \
    && git clone https://github.com/kamalsaleh/NConvex

USER gap
WORKDIR $HOME/inst
