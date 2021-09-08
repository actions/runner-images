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

# Specify Bazel version 3.7.1 to install due to the bug with 4.0.0: https://github.com/bazelbuild/bazel/pull/12882
if is_Less_Catalina; then
    export USE_BAZEL_VERSION="3.7.1"
    echo "export USE_BAZEL_VERSION=${USE_BAZEL_VERSION}" >> "${HOME}/.bashrc"
fi

# Invoke bazel to download bazel version via bazelisk
bazel

# Invoke tests for all basic tools
invoke_tests "BasicTools"
