# ==========================================
# 1. CMake builder
# ==========================================
FROM debian:trixie-slim AS builder

ARG CMAKE_VERSION=4.4.3

# ビルドに必要な依存関係をインストール
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates g++ make libssl-dev re2c \
    && rm -rf /var/lib/apt/lists/*

# 成果物を /usr/local/cmake-dist に集約します
RUN curl -OL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    && tar xf cmake-${CMAKE_VERSION}.tar.gz \
    && cd cmake-${CMAKE_VERSION} \
    && ./bootstrap --prefix=/usr/local/cmake-dist \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && rm -rf cmake-${CMAKE_VERSION}*

# ==========================================
# 2. Ninja Builder
# ==========================================
FROM debian:trixie-slim AS ninja-builder

ARG NINJA_VERSION=1.13.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl cmake g++ make python3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 成果物を /usr/local/ninja-dist に集約します
RUN curl -OL https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz \
    && tar xf v${NINJA_VERSION}.tar.gz \
    && cd ninja-${NINJA_VERSION} \
    && cmake -B build -DCMAKE_INSTALL_PREFIX=/usr/local/ninja-dist \
    && cmake --build build -j$(nproc) \
    && cmake --install ./build \
    && cd .. \
    && rm -rf ninja-${NINJA_VERSION} v${NINJA_VERSION}.tar.gz

# ==========================================
# 3. 実行用ステージ (Runner)
# ==========================================
FROM debian:trixie-slim

LABEL org.opencontainers.image.source="https://github.com/higma-container/cmake-ninja-docker-image"

# CMakeの実行に必要な最小限のランタイムライブラリ（libssl等）をインストール
# ※ NinjaはC++の標準ライブラリ（libstdc++6）だけで動くため、特別なパッケージは不要です
RUN apt-get update && apt-get install -y --no-install-recommends libssl3 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# builderステージから、CMake と Ninja のビルド済み成果物だけをコピー
COPY --from=builder /usr/local/cmake-dist/ /usr/local/
COPY --from=builder /usr/local/ninja-dist/ /usr/local/
