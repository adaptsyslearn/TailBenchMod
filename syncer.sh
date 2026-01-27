#!/bin/bash

DST=$1

while inotifywait -re modify "./harness/"
do
    scp -r harness/* $DST:/home/cc/tailbench/harness/
done
