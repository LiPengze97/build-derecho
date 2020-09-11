# sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list
sudo apt-get clean

# add gcc-7 packages
sudo apt-get -y update
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get -y update
sudo apt-get -y install gcc-7 g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --config gcc

# install other tools and dependencies
sudo apt-get -y install autoconf vim net-tools libssl-dev libreadline-dev libsnappy-dev libc-ares-dev \
librdmacm-dev libibverbs-dev libboost-dev libboost-system-dev \
libtool m4 automake wget curl make unzip iputils-ping git --fix-missing

bash prerequisites/install-cmake-3.18.sh
bash prerequisites/install-spdlog.sh
bash prerequisites/install-libfabric.sh
bash prerequisites/install-mutils.sh
bash prerequisites/install-mutils-containers.sh
bash prerequisites/install-mutils-tasks.sh
bash prerequisites/install-json.sh

bash build/build-derecho.sh
bash build/build-cascade.sh