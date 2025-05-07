#!/bin/bash -e
################################################################################
##  File:  install-ninja.sh
##  Desc:  Install ninja-build
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install ninja
download_url=$(resolve_github_release_asset_url "ninja-build/ninja" "endswith(\"ninja-linux.zip\")" "latest")
ninja_binary_path=$(download_with_retry "${download_url}")

# Unzip the ninja binary
unzip -qq "$ninja_binary_path" -d /usr/local/bin

invoke_tests "Tools" "Ninja"
