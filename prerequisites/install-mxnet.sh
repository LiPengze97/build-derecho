#!/bin/bash
set -eu
export TMPDIR=/var/tmp
INSTALL_PREFIX="/usr/local"
if [[ $# -gt 0 ]]; then
    INSTALL_PREFIX=$1
fi

echo "Using INSTALL_PREFIX=${INSTALL_PREFIX}"

WORKPATH=${HOME}
cd ${WORKPATH}
sudo apt-get update
sudo apt-get install -y ninja-build ccache libopenblas-dev libopencv-dev libatlas-base-dev libatlas3-base
sudo apt install gfortran

git clone --recursive https://github.com/apache/incubator-mxnet.git mxnet -b v1.7.x && cd mxnet
# 似乎不能再写回到原来文件，会变成空文件，写到一个新位置就好
cat make/config.mk | sed "s/USE_CPP_PACKAGE = 0/USE_CPP_PACKAGE = 1/g" > config.mk
make -j `lscpu | grep "^CPU(" | awk '{print $2}'`
sudo install -d ${INSTALL_PREFIX}/include/mxnet-cpp
sudo install cpp-package/include/mxnet-cpp/* ${INSTALL_PREFIX}/include/mxnet-cpp

sudo install -d ${INSTALL_PREFIX}/include/mxnet
sudo install include/mxnet/* ${INSTALL_PREFIX}/include/mxnet
sudo install -d ${INSTALL_PREFIX}/include/mxnet/ir
sudo install include/mxnet/ir/* ${INSTALL_PREFIX}/include/mxnet/ir
sudo install -d ${INSTALL_PREFIX}/include/mxnet/node
sudo install include/mxnet/node/* ${INSTALL_PREFIX}/include/mxnet/node
sudo install -d ${INSTALL_PREFIX}/include/mxnet/runtime
sudo install include/mxnet/runtime/* ${INSTALL_PREFIX}/include/mxnet/runtime

sudo install -d ${INSTALL_PREFIX}/include/dlpack
sudo install include/dlpack/* ${INSTALL_PREFIX}/include/dlpack

sudo install -d ${INSTALL_PREFIX}/include/dmlc
sudo install include/dmlc/* ${INSTALL_PREFIX}/include/dmlc

sudo install -d ${INSTALL_PREFIX}/include/mkldnn
sudo install include/mkldnn/* ${INSTALL_PREFIX}/include/mkldnn

sudo install -d ${INSTALL_PREFIX}/include/mshadow
sudo install include/mshadow/* ${INSTALL_PREFIX}/include/mshadow
sudo install -d ${INSTALL_PREFIX}/include/mshadow/cuda
sudo install include/mshadow/cuda/* ${INSTALL_PREFIX}/include/mshadow/cuda
sudo install -d ${INSTALL_PREFIX}/include/mshadow/extension
sudo install include/mshadow/extension/* ${INSTALL_PREFIX}/include/mshadow/extension
sudo install -d ${INSTALL_PREFIX}/include/mshadow/packet
sudo install include/mshadow/packet/* ${INSTALL_PREFIX}/include/mshadow/packet

sudo install -d ${INSTALL_PREFIX}/include/nnvm
sudo install include/nnvm/* ${INSTALL_PREFIX}/include/nnvm

sudo install -d ${INSTALL_PREFIX}/lib
sudo install lib/* ${INSTALL_PREFIX}/lib
# sudo make install