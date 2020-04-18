FROM fedora:31

LABEL MAINTAINER="SaigyoujiYuyuko <HGK-SaigyoujiYuyuko@outlook.com>"
LABEL Version "0.1"
LABEL Description "TrinityCore with AuthServer and WorldServer"

WORKDIR /build

RUN yum install git clang cmake3 make gcc gcc-c++ mysql-devel bzip2-devel readline-devel ncurses-devel boost-devel p7zip openssl openssl-devel -y \
  && yum clean all
  
RUN git clone -b 3.3.5 https://github.com/TrinityCore/TrinityCore.git \ 
  && cd TrinityCore \
  && mkdir build \
  && cd build \
  && cmake3 ../ -DCMAKE_INSTALL_PREFIX=/opt/trinity \
  && make -j 8 \
  && make install \
  && make clean \
  && cd /build && rm -rf TrinityCore

RUN chmod +x /opt/trinity/bin/authserver \
  && chmod +x /opt/trinity/bin/worldserver
  
FROM fedora:31

WORKDIR /opt/trinity

RUN yum install mysql-devel bzip2-devel readline-devel ncurses-devel boost-devel p7zip openssl openssl-devel -y \
  && yum clean all
  
COPY --from=0 /opt/trinity .

