#!/bin/bash -e
################################################################################
##  File:  cmake.sh
##  Desc:  Installs CMake
################################################################################

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if command -v cmake; then
    echo "cmake is already installed"
else
	VERSION=$(curl -s https://api.github.com/repos/Kitware/CMake/releases/latest | grep "tag_name" | cut -d'v' -f2 | cut -d'"' -f1)
	curl -sL https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-Linux-x86_64.sh -o cmakeinstall.sh \
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
