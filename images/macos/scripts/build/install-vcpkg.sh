#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-vcpkg.sh
##  Desc:  Install vcpkg
################################################################################

source ~/utils/utils.sh
#!/bin/bash

os=$(sw_vers -productVersion)  # Gets macOS version (e.g., 14.2)

# Check if macOS is Sonoma (14.x) or Sequoia (15.x) and on ARM
if [[ "$os" == 14.* || "$os" == 15.* ]] && [[ "$(uname -m)" == "arm64" ]]; then
    VCPKG_INSTALLATION_ROOT=/usr/local/bin/vcpkg
    echo "VCPKG_INSTALLATION_ROOT set to: $VCPKG_INSTALLATION_ROOT"
fi

# Set env variable for vcpkg
VCPKG_INSTALLATION_ROOT=/usr/local/share/vcpkg
echo "export VCPKG_INSTALLATION_ROOT=${VCPKG_INSTALLATION_ROOT}" | tee -a ~/.bashrc

# workaround https://github.com/microsoft/vcpkg/issues/27786

mkdir -p /Users/runner/.vcpkg
touch /Users/runner/.vcpkg/vcpkg.path.txt

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg $VCPKG_INSTALLATION_ROOT
$VCPKG_INSTALLATION_ROOT/bootstrap-vcpkg.sh
$VCPKG_INSTALLATION_ROOT/vcpkg integrate install
chmod -R 0777 $VCPKG_INSTALLATION_ROOT
ln -sf $VCPKG_INSTALLATION_ROOT/vcpkg /usr/local/bin

rm -rf /Users/runner/.vcpkg

invoke_tests "Common" "vcpkg"
