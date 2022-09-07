#!/bin/bash -e
################################################################################
##  File:  vcpkg.sh
##  Desc:  Installs vcpkg
################################################################################

# Set env variables for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a /etc/environment

VCPKG_ROOT=/usr/local/share/vcpkg
echo "VCPKG_ROOT=${VCPKG_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_ROOT

$VCPKG_ROOT/bootstrap-vcpkg.sh
$VCPKG_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_ROOT
ln -sf $VCPKG_ROOT/vcpkg /usr/local/bin

invoke_tests "Tools" "Vcpkg"