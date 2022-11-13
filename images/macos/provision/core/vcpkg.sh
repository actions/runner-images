#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# Set env variable for vcpkg
GIT_COMMIT_HASH="59b58fc56de40eaa279ae0208debcf5773a2db77"
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "export VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a ~/.bashrc

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT

pushd $VCPKG_INSTALLATION_ROOT
git checkout $GIT_COMMIT_HASH
popd

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod -R 0777 $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

invoke_tests "Common" "vcpkg"
