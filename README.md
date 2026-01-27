# TailBench Modified
The harness folder has been updated from original [TailBench](https://tailbench.csail.mit.edu/) for tracking some application related information. 

Works fine for: 

OS - Ubuntu 22.04.5 LTS
Kernel - 6.8.0-59-generic
Architecture - Raptor Lake Refresh 

# Install tailbench.inputs from the following command - 


## Step 1: Download and Extract `tailbench.inputs`

This has to be installed by the user as tailbench.inputs is too big for Github. 
Run the following command to download the `tailbench.inputs` archive:

```bash
wget http://tailbench.csail.mit.edu/tailbench.inputs.tgz 
```
These are the inputs for tailbench applications. Extract it to a suitable position and update configs.sh in tailbench folder.


## Install dependencies.
```
sudo apt-get -y install software-properties-common
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt-get update
```

Install opencv for img-dnn and java version 8 

```
sudo apt -y install openjdk-8-jdk
sudo apt-get -y --assume-yes install gcc automake autoconf libtool bison swig build-essential vim python3.7 \
             pkg-config python3-pip zlib1g-dev uuid-dev libboost-all-dev cmake libgtk2.0-dev pkg-config \
             libqt4-dev unzip wget libjasper-dev libpng-dev libjpeg-dev libtiff5-dev libgdk-pixbuf2.0-dev \
             libopenexr-dev libbz2-dev tk-dev tcl-dev g++ git subversion automake libtool zlib1g-dev libicu-dev
             libboost-all-dev liblzma-dev python-dev graphviz imagemagick make cmake \
             libgoogle-perftools-dev autoconf doxygen libgtop2-dev libncurses-dev ant libnuma-dev \
             libmysqld-dev libaio-dev libjemalloc-dev libdb5.3++-dev libreadline-dev


wget https://github.com/opencv/opencv/archive/2.4.13.5.zip -O opencv-2.4.13.5.zip
unzip opencv-2.4.13.5.zip
```
Go into the extracted folder and make a folder called release and install it.
```
cd ./opencv-2.4.13.5/
mkdir release
cd release/
cmake -G "Unix Makefiles" -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc \
         -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON \
         -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON \
         -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON \
         -DBUILD_FAT_JAVA_LIB=ON -DINSTALL_TO_MANGLED_PATHS=ON -DINSTALL_CREATE_DISTRIB=ON \
         -DINSTALL_TESTS=ON -DENABLE_FAST_MATH=ON -DWITH_IMAGEIO=ON -DBUILD_SHARED_LIBS=OFF \
         -DWITH_GSTREAMER=ON -DWITH_JASPER=OFF ..
sudo make install
```
```
pip3 install developer-tools numpy matplotlib pandas scipy
```
For xapian - 
```
cd xapian-core-1.2.13
sudo ./configure
sed -i 's/CXX = g++/CXX = g++ -std=c++03/g' Makefile
sudo make -j$(nproc) && sudo make install
cd ..	
```
For other applications, go to their directories and use `./build.sh`

You also need to modify the `LD_LIBRARY_PATH` in `xapian/run.sh` and `xapian/run_integrated.sh`, others make use of relative paths.

## Using the `run_all.sh` script in tailbench directory

If you run it without any arguments, it will run all the applications in integrated form.

If you want to specify the type and the applications, do so in the following manner-

`bash run_all.sh integrated|networked app1 app2 app3 ..`

Where applications are `xapian`, `masstree`, `img-dnn`, `moses`, `shore`, `silo`, `sphinx`.

Note: There are problems in setting up TailBench without root/sudo access. 
      Makes use of various system-related aspects related to `chrt` etc. 
