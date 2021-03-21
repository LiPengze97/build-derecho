# sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
apt-get clean

# add gcc-8 packages
apt-get -y update
apt-get install software-properties-common -y
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get -y update
apt-get -y install gcc-8 g++-8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8
update-alternatives --config gcc

# install other tools and dependencies
apt-get -y install autoconf vim net-tools libssl-dev libreadline-dev libsnappy-dev libc-ares-dev \
librdmacm-dev libibverbs-dev libboost-dev libboost-system-dev \
libtool m4 automake wget curl make unzip iputils-ping git --fix-missing

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

prerequisites-cornell-no-sudo/install-cmake-3.18.sh
prerequisites-cornell-no-sudo/install-spdlog.sh
prerequisites-cornell-no-sudo/install-libfabric.sh
prerequisites-cornell-no-sudo/install-mutils.sh
prerequisites-cornell-no-sudo/install-mutils-containers.sh
prerequisites-cornell-no-sudo/install-mutils-tasks.sh
prerequisites-cornell-no-sudo/install-json.sh
prerequisites-cornell-no-sudo/install-openssl-1.1.1.sh
prerequisites-cornell-no-sudo/install-gccjit.sh
prerequisites-cornell-no-sudo/install-linq.sh
prerequisites-cornell-no-sudo/install-fuse.sh
prerequisites-cornell-no-sudo/install-mxnet.sh

build-cornell-no-sudo/build-derecho.sh
build-cornell-no-sudo/build-cascade.sh

sysctl -w vm.overcommit_memory=1