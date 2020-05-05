#!/bin/bash
################################################################################
##  File:  cmake.sh
##  Desc:  Installs CMake
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if command -v cmake; then
    echo "cmake is already installed"
else
	curl -sL https://cmake.org/files/v3.17/cmake-3.17.0-Linux-x86_64.sh -o cmakeinstall.sh \
	&& chmod +x cmakeinstall.sh \
	&& ./cmakeinstall.sh --prefix=/usr/local --exclude-subdir \
	&& rm cmakeinstall.sh
fi

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v cmake; then
    echo "cmake was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "CMake ($(cmake --version | head -n 1))"
