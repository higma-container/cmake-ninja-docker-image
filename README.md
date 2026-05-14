# Tools version

- CMake 3.31.5
- ninja 1.12.1

# Build

```sh
docker build -t ghcr.io/higma-container/cmake-ninja:v0.6 .
```

# Push

```sh
docker push ghcr.io/higma-container/cmake-ninja:v0.6
```

# Multi Architecture

```sh
docker build --platform linux/amd64,linux/arm64 -t ghcr.io/higma-container/cmake-ninja:v0.6 --push .
```
