#!/bin/bash -e
################################################################################
##  File:  hhvm.sh
##  Desc:  Installs hhvm
################################################################################

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94
add-apt-repository https://dl.hhvm.com/ubuntu
echo 'Acquire::https::dl.hhvm.com::Verify-Peer "false";' > /etc/apt/apt.conf.d/99hhvm-cert
apt-get update
apt-get -qq install -y hhvm
rm /etc/apt/apt.conf.d/99hhvm-cert

invoke_tests "Tools" "HHVM"
