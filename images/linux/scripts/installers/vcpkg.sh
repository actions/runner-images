#!/bin/bash -e
################################################################################
##  File:  vcpkg.sh
##  Desc:  Installs vcpkg
################################################################################

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh

# workaround https://github.com/microsoft/vcpkg/issues/27786

mkdir -p /root/.vcpkg/ $HOME/.vcpkg
touch /root/.vcpkg/vcpkg.path.txt $HOME/.vcpkg/vcpkg.path.txt

$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

rm -rf /root/.vcpkg $HOME/.vcpkg

invoke_tests "Tools" "Vcpkg"