#!/usr/bin/env bash

cd "$(dirname "$0")"

# docker build --platform=linux/amd64 -f Dockerfile.macos-aarch64 . -t osxcross-rust:aarch64
docker build -f Dockerfile . -t zone117x/osxcross-rust
docker push zone117x/osxcross-rust
# docker buildx build --platform linux/amd64,linux/arm64 -t username/demo:latest --push .