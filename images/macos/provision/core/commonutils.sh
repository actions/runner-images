#!/bin/bash -e -o pipefail
source ~/utils/utils.sh
source ~/utils/invoke-tests.sh

# Install jq for parsing toolset file
echo "Install jq"
brew install jq

toolset=$(get_toolset_path)
common_packages=$(jq -r ".brew.common_packages[]" $toolset)
for package in $common_packages; do
    echo "Install $package"
    brew install $package
done

cask_common_packages=$(jq -r ".brew.cask_common_packages[]" $toolset)
for package in $cask_common_packages; do
    echo "Install $package"
    brew cask install $package
done

# Invoke bazel to download the latest bazel version via bazelisk
bazel

# Invoke tests for all common tools
invoke_tests "Common" "Brew common utilities"