#!/bin/bash

sudo apt update
sudo apt install -y libaio-dev libjemalloc-dev

MODE=perf make -j16
MODE=perf make -j16 dbtest
