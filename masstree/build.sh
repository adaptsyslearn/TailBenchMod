#!/bin/bash

# Install tcmalloc
sudo apt install -y google-perftools
cd /usr/lib/
sudo ln -s ./x86_64-linux-gnu/libtcmalloc_minimal.so.4.5.3 libtcmalloc_minimal.so
cd -

autoconf
./configure --disable-assertions --with-malloc=tcmalloc
make -j16
