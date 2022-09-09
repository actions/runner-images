#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Set env variables for vcpkg
VCPKG_ROOT=/usr/local/share/vcpkg
echo "export VCPKG_INSTALLATION_ROOT=${VCPKG_ROOT}" | tee -a ~/.bashrc
echo "export VCPKG_ROOT=${VCPKG_ROOT}" | tee -a ~/.bashrc

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_ROOT
$VCPKG_ROOT/bootstrap-vcpkg.sh
$VCPKG_ROOT/vcpkg integrate install
chmod -R 0777 $VCPKG_ROOT
ln -sf $VCPKG_ROOT/vcpkg /usr/local/bin

invoke_tests "Common" "vcpkg"
