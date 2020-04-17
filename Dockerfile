FROM fedora:31

LABEL MAINTAINER="SaigyoujiYuyuko <HGK-SaigyoujiYuyuko@outlook.com>"
LABEL Version "0.1"
LABEL Description "TrinityCore with AuthServer and WorldServer"

WORKDIR /root

RUN yum install git clang cmake3 make gcc gcc-c++ mysql-devel bzip2-devel readline-devel ncurses-devel boost-devel p7zip openssl openssl-devel -y

RUN git clone -b 3.3.5 https://github.com/TrinityCore/TrinityCore.git
 
RUN cd TrinityCore \
  && mkdir build \
  && cd build \
  && cmake3 ../ -DBOOST_ROOT=/usr/local/boost -DCMAKE_INSTALL_PREFIX=/opt/trinity \
  && make -j 8 \
  && make install \
  && cd /root && rm -rf TrinityCore

RUN chmod +x /opt/trinity/bin/authserver
  
ENTRYPOINT ["./opt/trinity/bin/authserver"]

