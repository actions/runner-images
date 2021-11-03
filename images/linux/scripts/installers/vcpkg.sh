#!/bin/bash -e
################################################################################
##  File:  vcpkg.sh
##  Desc:  Installs vcpkg
################################################################################

# Set env variable for vcpkg

# Checkout the specific commit as master builds are falling.
# Upstream report: https://github.com/microsoft/vcpkg/issues/21107
GIT_COMMIT_HASH=d78a0b47bdd4deb6bc5547e06e289672892ed226
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT

pushd $VCPKG_INSTALLATION_ROOT
git checkout $GIT_COMMIT_HASH
popd

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_INSTALLATION_ROOT
mkdir -p /usr/local/bin
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin/vcpkg

invoke_tests "Tools" "Vcpkg"
