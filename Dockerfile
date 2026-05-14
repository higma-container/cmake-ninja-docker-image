FROM debian:bookworm-slim

ARG CMAKE_VERSION=4.3.2
ARG NINJA_VERSION=1.13.1

RUN apt-get update \
    && apt-get install -y curl g++ make libssl-dev re2c \
    && curl -OL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar xf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap \
    && make -j`nproc` \
    && make install \
    && cd .. \
    && rm -fr cmake-${CMAKE_VERSION}* \
    && curl -OL https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz \
    && tar xf v${NINJA_VERSION}.tar.gz \
    && cd ninja-${NINJA_VERSION}/ \
    && cmake -B build-cmake \
    && cmake --build build-cmake \
    && cmake --install ./build-cmake \
    && cd .. \
    && rm -fr ninja-${NINJA_VERSION}/ v${NINJA_VERSION}.tar.gz \
    && apt-get purge -y curl g++ make libssl-dev re2c \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/*
