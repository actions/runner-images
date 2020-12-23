#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

# Setup the Cocoapods
echo "Installing Cocoapods..."
pod setup

# Create a symlink to /usr/local/bin since it was removed due to Homebrew change.
ln -sf $(which pod) /usr/local/bin/pod

invoke_tests "Common" "CocoaPods"