#!/bin/bash

set -x
set -e

DEFAULT_VERSION=v226

[ ! -d capic-poc ] && git clone http://github.com/GENIVI/capic-poc
[ ! -d systemd ] && git clone http://github.com/systemd/systemd

# BUILDING SYSTEMD
#---------------------------------------------------

# Version given on commandline?
version="$DEFAULT_VERSION"
[ -n "$1" ] && version=$1

cd systemd

# Clean all just in case
git reset --hard && git clean -fdx
git checkout $version
meson build/ && ninja -C build

# BUILDING COMMON-API C
#---------------------------------------------------

# The following 3 moves of content are done because it's similar
# to the setup in Go pipelines.
mkdir -p ../capic-poc/systemd/libs
cp build/*.so* ../capic-poc/systemd/libs/
mkdir -p ../capic-poc/systemd/headers
cp -r src/systemd ../capic-poc/systemd/headers/

cd ../capic-poc
autoreconf -i

export LIBSYSTEMD_CFLAGS="-I$PWD/systemd/headers" 
export LIBSYSTEMD_LIBS="-L$PWD/systemd/libs" 
./configure LDFLAGS="-L$PWD/systemd/libs"
make -j8
