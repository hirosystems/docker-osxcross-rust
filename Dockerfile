FROM debian:stable as build

ARG OSXCROSS_BRANCH="d904031"
ARG MACOSX_SDK_DL=https://github.com/joseluisq/macosx-sdks/releases/download/12.0/MacOSX12.0.sdk.tar.xz
ARG MACOSX_SDK_SHASUM=ac07f28c09e6a3b09a1c01f1535ee71abe8017beaedd09181c8f08936a510ffd

RUN apt-get update && apt-get install -y git clang cmake wget xz-utils libssl-dev lzma-dev libxml2-dev

RUN git clone --depth 1 -b ${OSXCROSS_BRANCH} https://github.com/hirosystems/osxcross /opt/osxcross

RUN cd /opt/osxcross/tarballs && \
    wget -nc $MACOSX_SDK_DL

RUN cd /opt/osxcross/tarballs && echo "$MACOSX_SDK_SHASUM `basename $MACOSX_SDK_DL`" | sha256sum -c

RUN cd /opt/osxcross && UNATTENDED=1 ./build.sh

FROM scratch

COPY --from=build /opt/osxcross/target /opt/osxcross
COPY env-macos-aarch64.sh /opt/env-macos-aarch64
COPY env-macos-x86_64.sh /opt/env-macos-x86_64
