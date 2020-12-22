#!/bin/bash -e
################################################################################
##  File:  hhvm.sh
##  Desc:  Installs hhvm
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94
add-apt-repository https://dl.hhvm.com/ubuntu
apt-get update
apt-get -qq install -y hhvm

Invoke_tests "Tools" "HHVM"
