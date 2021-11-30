#/bin/sh

export PATH="/opt/osxcross/bin:${PATH}"
export LD_LIBRARY_PATH="/opt/osxcross/lib:${LD_LIBRARY_PATH}"

export DARWIN_TARGET=x86_64-apple-darwin21.1
export TARGET_CC=${DARWIN_TARGET}-clang
export CC=${DARWIN_TARGET}-clang
export CXX=${DARWIN_TARGET}-clang-clang++
export CC_x86_64_apple_darwin=${DARWIN_TARGET}-clang
export CARGO_TARGET_X86_64_APPLE_DARWIN_LINKER=${DARWIN_TARGET}-clang
export CARGO_TARGET_X86_64_APPLE_DARWIN_AR=${DARWIN_TARGET}-ar
export LIBZ_SYS_STATIC=1