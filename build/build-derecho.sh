#!/bin/bash

set -eu
WORKPATH="${HOME}"
INSTALL_PREFIX="/usr/local"
if [[ $# -gt 0 ]]; then
    INSTALL_PREFIX=$1
fi

echo "Using INSTALL_PREFIX=${INSTALL_PREFIX}"
cd ${WORKPATH}

if [ -d "derecho" ];then
  rm -rf derecho
fi

git clone -b register_more_rpc_functions --recursive https://github.com/Panlichen/derecho.git
cd derecho

mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} ..
make -j `lscpu | grep "^CPU(" | awk '{print $2}'`
sudo make install