FROM debian:stable as build

ARG OSXCROSS_BRANCH="d904031"
ARG MACOSX_SDK_DL=https://github.com/hirosystems/docker-osxcross-rust/releases/download/MacOSX12.0.sdk/MacOSX12.0.sdk.tar.xz
ARG MACOSX_SDK_SHASUM=ac07f28c09e6a3b09a1c01f1535ee71abe8017beaedd09181c8f08936a510ffd

# Install osxcross build deps
RUN apt-get update && apt-get install -y git clang cmake wget xz-utils zstd libssl-dev lzma-dev libxml2-dev

# Clone osxcross
RUN git clone --depth 1 -b ${OSXCROSS_BRANCH} https://github.com/hirosystems/osxcross /opt/osxcross

# Fetch MacOSX SDK
RUN cd /opt/osxcross/tarballs && wget -nc $MACOSX_SDK_DL

# Verify MacOSX-SDK tarball shasum
RUN cd /opt/osxcross/tarballs && echo "$MACOSX_SDK_SHASUM `basename $MACOSX_SDK_DL`" | sha256sum -c

# Build osxcross
RUN cd /opt/osxcross && UNATTENDED=1 ./build.sh

# Copy in helper scripts
COPY env-macos-aarch64.sh /opt/osxcross/target/env-macos-aarch64
COPY env-macos-x86_64.sh /opt/osxcross/target/env-macos-x86_64

# Compress result
RUN mkdir /output && cd /output && tar -caf "osxcross-${OSXCROSS_BRANCH}_MacOSX12.0.sdk.tar.zst" -C /opt/osxcross/target .

FROM scratch as export-stage
COPY --from=build /output/* /
