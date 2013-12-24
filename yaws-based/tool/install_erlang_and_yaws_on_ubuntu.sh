#!/bin/bash

# Install Erlang
cd ~
mkdir -p src
cd src/
sudo apt-get install -y ncurses-dev openjdk-7-jdk libcurl4-openssl-dev unixodbc-dev
wget http://www.erlang.org/download/otp_src_R16B02.tar.gz
tar xf otp_src_R16B02.tar.gz
cd otp_src_R16B02/
./configure
make
sudo make install
cd ~

# Install Yaws
cd ~
mkdir -p src
cd src/
sudo apt-get install -y libpam0g-dev
wget http://yaws.hyber.org/download/yaws-1.98.tar.gz
tar xf yaws-1.98.tar.gz
cd yaws
./configure
make
sudo make install
cd ~


