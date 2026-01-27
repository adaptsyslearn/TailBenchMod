#!/bin/bash

sudo apt install -y libboost1.61-all-dev libbz2-dev

export TBENCH_PATH=${PWD}/../harness
export CPATH=${TBENCH_PATH}${CPATH:+:$CPATH}
./bjam toolset=gcc --user-config=user-config.jam -j32 -q
