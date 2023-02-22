#!/bin/bash

# Script for building MySQL such that it can be run with mtr
cd mtr-build
echo "Building MySQL in folder: $PWD"

echo "Running cmake"
cmake ../mysql-server/ -DDOWNLOAD_BOOST=1 -DCMAKE_BUILD_TYPE=Debug -GNinja

echo "Running ninja"
# Use -j4 to build with 4 threads, more threads require more RAM (> 16 GB)
ninja -j4
