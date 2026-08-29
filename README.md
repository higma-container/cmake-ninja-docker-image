# CMake + Ninja Docker Image

CMake と Ninja がインストールされた Debian ベースの Docker イメージです。

CMake / Ninja を利用する CI やビルド環境などで使用できます。

## Tools Version

* CMake 4.4.3
* Ninja 1.13.2

## Supported Platforms

以下のプラットフォームに対応しています。

* `linux/amd64`
* `linux/arm64`

Docker が実行環境に応じて適切なイメージを自動的に選択します。

## Usage

### Pull

最新バージョンを取得する場合：

```sh
docker pull ghcr.io/higma-container/cmake-ninja:latest
```

バージョンを指定する場合：

```sh
docker pull ghcr.io/higma-container/cmake-ninja:v0.8
```

### Check Versions

CMake：

```sh
docker run --rm \
  ghcr.io/higma-container/cmake-ninja:latest \
  cmake --version
```

Ninja：

```sh
docker run --rm \
  ghcr.io/higma-container/cmake-ninja:latest \
  ninja --version
```

## CI / Release

GitHub Actions を使用して Docker イメージをビルドしています。

`main` ブランチへの push および Pull Request では、以下のテストを実行します。

* `linux/amd64` のビルド
* `linux/arm64` のビルド
* CMake の起動確認
* Ninja の起動確認

GitHub Release を発行すると、`linux/amd64` と `linux/arm64` のイメージをビルドし、GHCRへpushします。

リリース時には Multi-platform manifest が作成されるため、利用者はアーキテクチャを意識せずにイメージを取得できます。

例えば `v0.8` をリリースした場合：

```sh
docker pull ghcr.io/higma-container/cmake-ninja:v0.8
```

または：

```sh
docker pull ghcr.io/higma-container/cmake-ninja:latest
```

## Repository

* GitHub: `higma-container/cmake-ninja-docker-image`
* Container Registry: `ghcr.io/higma-container/cmake-ninja`
