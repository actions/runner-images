#!/bin/bash -e
################################################################################
##  File:  install-ninja.sh
##  Desc:  Install ninja-build
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

if is_x64; then
  ninja_asset_name="ninja-linux.zip"
elif is_arm64; then
  ninja_asset_name="ninja-linux-aarch64.zip"
else
  echo "Unsupported architecture"
  exit 1
fi

# Install ninja
download_url=$(resolve_github_release_asset_url "ninja-build/ninja" "endswith(\"${ninja_asset_name}\")" "latest")
ninja_binary_path=$(download_with_retry "${download_url}")

# Unzip the ninja binary
unzip -qq "$ninja_binary_path" -d /usr/local/bin

invoke_tests "Tools" "Ninja"
