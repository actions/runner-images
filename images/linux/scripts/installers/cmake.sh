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
	json=$(curl -s "https://api.github.com/repos/Kitware/CMake/releases")
	latest_tag=$(echo $json | jq -r '.[] | select(.prerelease==false).tag_name' | sort --unique --version-sort | grep -v "rc" | tail -1)
	sh_url=$(echo $json | jq -r ".[] | select(.tag_name==\"${latest_tag}\").assets[].browser_download_url | select(endswith(\"inux-x86_64.sh\"))")
	curl -sL ${sh_url} -o cmakeinstall.sh \
	&& chmod +x cmakeinstall.sh \
	&& ./cmakeinstall.sh --prefix=/usr/local --exclude-subdir \
	&& rm cmakeinstall.sh
fi

invoke_tests "Tools" "Cmake"
