#!/bin/bash -e
################################################################################
##  File:  cmake.sh
##  Desc:  Installs CMake
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if command -v cmake; then
    echo "cmake is already installed"
else
	downloadUrl=$(get_github_package_download_url "Kitware/CMake" "endswith(\"inux-x86_64.sh\")")
	curl -fsSL ${downloadUrl} -o cmakeinstall.sh \
	&& chmod +x cmakeinstall.sh \
	&& ./cmakeinstall.sh --prefix=/usr/local --exclude-subdir \
	&& rm cmakeinstall.sh
fi

invoke_tests "Tools" "Cmake"
