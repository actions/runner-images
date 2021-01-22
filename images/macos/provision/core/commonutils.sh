#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

common_packages=$(get_toolset_value '.brew.common_packages[]')
for package in $common_packages; do
    echo "Installing $package..."
    brew_smart_install "$package"
done

cask_packages=$(get_toolset_value '.brew.cask_packages[]')
for package in $cask_packages; do
    echo "Installing $package..."
    brew install --cask $package
done

# Invoke bazel to download the latest bazel version via bazelisk
bazel

# Invoke tests for all common tools
invoke_tests "Common" "CommonUtils"
