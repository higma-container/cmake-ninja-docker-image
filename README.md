# Overview

CMakeとninjaがインストールされた環境のdockerイメージ

手動でビルドすることもciでビルドすることもできる

## Tools version

- CMake 4.4.3
- ninja 1.13.2

## CI

mainにpushするとイメージのビルドを行います。リリースを発行するとイメージをレジストリにプッシュします。

## 手動Build

```sh
docker build -t ghcr.io/higma-container/cmake-ninja:v0.7 .
```

## Push

```sh
docker push ghcr.io/higma-container/cmake-ninja:v0.7
```

## Multi Architecture

```sh
docker build --platform linux/amd64,linux/arm64 -t ghcr.io/higma-container/cmake-ninja:v0.7 --push .
```
