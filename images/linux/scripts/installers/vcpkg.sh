#!/bin/bash
################################################################################
##  File:  vcpkg.sh
##  Desc:  Installs vcpkg
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a /etc/environment

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT
# Workaround to avoid issues caused by this PR https://github.com/microsoft/vcpkg/pull/10834
cd $VCPKG_INSTALLATION_ROOT
git checkout 1e19af09e53e5f306ed89c2033817a21e5ee0bcf

$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod 0777 -R $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v vcpkg; then
    echo "vcpkg was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Vcpkg $(vcpkg version | head -n 1 | cut -d ' ' -f 6)"
