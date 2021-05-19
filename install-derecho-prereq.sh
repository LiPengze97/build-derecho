# sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
sudo apt-get clean

# add gcc-8 packages
sudo apt-get -y update
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get -y update
sudo apt-get -y install gcc-8 g++-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8
sudo update-alternatives --config gcc

# install other tools and dependencies
sudo apt-get -y install autoconf vim net-tools libssl-dev libreadline-dev libsnappy-dev libc-ares-dev \
librdmacm-dev libibverbs-dev libboost-dev libboost-system-dev \
libtool m4 automake wget curl make unzip iputils-ping git --fix-missing

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

prerequisites-cornell/install-cmake-3.18.sh
echo -e "\n install-cmake-3.18.sh done \n"
prerequisites-cornell/install-spdlog.sh
echo -e "\n install-spdlog.sh done \n"
prerequisites-cornell/install-libfabric.sh
echo -e "\n install-libfabric.sh done \n"
prerequisites-cornell/install-mutils.sh
echo -e "\n install-mutils.sh done \n"
prerequisites-cornell/install-mutils-containers.sh
echo -e "\n install-mutils-containers.sh done \n"
prerequisites-cornell/install-mutils-tasks.sh
echo -e "\n install-mutils-tasks.sh done \n"
prerequisites-cornell/install-json.sh
echo -e "\n install-json.sh done \n"
prerequisites-cornell/install-openssl-1.1.1.sh
echo -e "\n install-openssl-1.1.1.sh done \n"
# prerequisites-cornell/install-gccjit.sh
prerequisites-cornell/install-linq.sh
echo -e "\n install-linq.sh done \n"
prerequisites-cornell/install-fuse.sh
echo -e "\n install-fuse.sh done \n"
# prerequisites-cornell/install-mxnet.sh

# build-cornell/build-derecho.sh
# echo -e "\n build-derecho.sh done \n"
# build-cornell/build-cascade.sh

sudo sysctl -w vm.overcommit_memory=1