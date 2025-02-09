# CMake

cmakeとninjaをソースからコンパイルしてインストールする

- CMake 3.31.5
- ninja 1.12.1

# Build

```sh
docker build --platform linux/amd64,linux/arm64 -t yoshiyasu1111/cmake-ninja:v0.5 .
```

# Start Container

```sh
docker run -it yoshiyasu1111/cmake-ninja:v0.5 /bin/bash  
```
