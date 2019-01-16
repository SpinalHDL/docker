ARG IMAGE="ubuntu:xenial"

FROM $IMAGE AS common

WORKDIR /work

RUN apt update -qq && apt upgrade -y && apt install -y --no-install-recommends \
      apt-utils \
      apt-transport-https \
      ca-certificates \
      git \
      make \
  && apt update -qq && apt autoclean && apt clean && apt -y autoremove \
  && update-ca-certificates

#
# Temporal image to build deps
#

FROM common AS build

RUN apt install -y --no-install-recommends \
      autoconf \
      bison \
      clang-6.0 \
      flex \
      g++ \
      gcc \
      gnat-5 \
      gperf \
      llvm-6.0-dev \
      readline-common \
      zlib1g-dev

  # Build GHDL
RUN git clone https://github.com/ghdl/ghdl && cd ghdl \
 && git reset --hard "50da90f509aa6de2961f1795af0be2452bc2c6d9" \
 && ./dist/travis/build.sh -b llvm-6.0 -p ghdl-llvm \
 && mv ghdl-llvm.tgz /tmp \
 && cd ..

  # Build Verilator
RUN git clone http://git.veripool.org/git/verilator --branch verilator_4_008 && cd verilator \
 && unset VERILATOR_ROOT \
 && autoconf \
 && ./configure --prefix="/usr/local/"\
 && make -j$(nproc) \
 && make install DESTDIR="$(pwd)/install-verilator" \
 && mv install-verilator/usr/local /tmp/verilator \
 && cd ..

  # Build iverilog
RUN git clone https://github.com/steveicarus/iverilog --depth=1 --branch v10_2 && cd iverilog \
 && autoconf \
 && ./configure \
 && make -j$(nproc) \
 && make install DESTDIR="$(pwd)/install-iverilog" \
 && mv install-iverilog/usr/local /tmp/iverilog \
 && ls -la /tmp/iverilog \
 && cd ..

#
# Add deps to base image: GHDL, Verilator, iverilog, VUnit and cocotb
#

FROM common AS deps

RUN apt install -y --no-install-recommends \
      libgnat-5 \
      python3 \
      python3-pip \
      python \
      python-dev \
      swig \
      zlib1g-dev \
  && apt autoclean && apt clean && apt -y autoremove

COPY --from=build /tmp/ghdl-llvm.tgz /tmp/ghdl.tgz
COPY --from=build /tmp/verilator/ /usr/local/
COPY --from=build /tmp/iverilog/ /usr/local/

RUN tar -xzf /tmp/ghdl.tgz -C /usr/local \
 && rm -f /tmp/*

RUN git clone --recurse-submodule https://github.com/vunit/vunit /opt/vunit \
 && pip3 install -r /opt/vunit/requirements.txt

RUN git clone https://github.com/potentialventures/cocotb /opt/cocotb \
  && cd /opt/cocotb \
  && git reset --hard a463cee498346cb26fc215ced25c088039490665

ENV PYTHONPATH=/opt/vunit
ENV COCOTB=/opt/cocotb

#
# Add scala
#

FROM deps AS base

## Set frontend required for docker
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -qq && apt install -y --no-install-recommends \
      gnupg2 \
 && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
 && apt update -qq && apt install -y --no-install-recommends \
   g++ \
   sbt \
   scala \
 && apt autoclean && apt clean && apt -y autoremove

#
# opnjdk-8
#

FROM base

RUN apt update -qq && apt install -y --no-install-recommends \
      openjdk-8-jdk \
  && apt autoclean && apt clean && apt -y autoremove
