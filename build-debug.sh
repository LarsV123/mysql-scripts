#!/bin/bash

# Script for building MySQL such that it can be run with
# ./debug-build/runtime_output_directory/mysqld --datadir=./data --initialize-insecure

# The script assumes that the project is placed at ~/mysql,
# with the mysql-server folder at ~/mysql/mysql-server

BUILD_DIR=~/mysql/debug-build
DATA_DIR=~/mysql/data

# Exit on error
set -e

# Create data folder (no error if it already exists)
mkdir -p $DATA_DIR

# Create build folder (no error if it already exists)
mkdir -p $BUILD_DIR
cd $BUILD_DIR
echo "Building MySQL in folder: $PWD"

echo "Running cmake"
cmake ../mysql-server/ \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
  -DWITH_SYSTEM_LIBS=0 \
  -DWITH_UNIT_TESTS=0 \
  -DWITH_ROUTER=0 \
  -DWITH_AUTHENTICATION_FIDO=0 \
  -DWITH_NDB=0 \
  -DWITH_DEBUG=1 \
  -DMYSQL_MAINTAINER_MODE=1 \
  -DWITH_ZLIB=bundled \
  -DDOWNLOAD_BOOST=1 \
  -DWITH_BOOST=~/mysql/boost \
  -DWITH_ASAN=1 \
  -DWITH_NDBCLUSTER_STORAGE_ENGINE=0 \
  -DCMAKE_BUILD_TYPE=Debug \
  -DWITH_ICU=system \
  -GNinja

echo "Running ninja"
# Use -j4 to build with 4 threads, more threads require more RAM (> 16 GB)
ninja -j4

echo "Done building MySQL"

INIT_SERVER="${BUILD_DIR}/runtime_output_directory/mysqld --datadir=./data --initialize-insecure"
RUN_SERVER="${BUILD_DIR}/runtime_output_directory/mysqld --datadir=./data"
RUN_CLIENT="${BUILD_DIR}/runtime_output_directory/mysql -uroot"

printf "\n**********\n"
printf "Initialize server:\n  ${INIT_SERVER}\n"
printf "Run server:\n  ${RUN_SERVER}\n"
printf "Run client:\n  ${RUN_CLIENT}\n"
