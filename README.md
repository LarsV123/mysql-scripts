# Setup

```bash
# Install required system packages
# Build tools
sudo apt install make ninja-build g++ clang bison cmake pkg-config

# Debuggers and test tools
sudo apt install lld lldb ddd xterm libjson-perl doxygen plantuml dia libcanberra-gtk-module clang-tidy

# Other dependencies
sudo apt install libssl-dev libncurses-dev libldap-dev libsasl2-dev libudev-dev
sudo apt install libzstd-dev libedit-dev liblz4-dev libcurl4-openssl-dev protobuf-compiler dpkg-dev

# Delete old build directory if needed
rm -Rf mtr-build
mkdir mtr-build
cd build-debug
cmake ../mysql-server/ -DDOWNLOAD_BOOST=1 -DCMAKE_BUILD_TYPE=Debug -GNinja
```

# Usage

```bash

# Build a debug version of MySQL
bash debug-build.sh

# Initialize server (first time only)
./build-debug/runtime_output_directory/mysqld --datadir=../data --initialize-insecure

# Start server
./build-debug/runtime_output_directory/mysqld --datadir=../data

# Start client (from a separate terminal)
./build-debug/runtime_output_directory/mysql -uroot
```

```sql
-- Set up database and user with permission to access it
CREATE DATABASE my_project;
CREATE USER 'lars'@'%LARS-LENOVO.mshome.net' IDENTIFIED BY 'examplepassword';
GRANT ALL PRIVILEGES ON *.* TO 'lars'@'%LARS-LENOVO.mshome.net';

-- Shut down the server (from the client)
SHUTDOWN;
```
