#!/bin/bash -e
################################################################################
##  File:  install-bazel.sh
##  Desc:  Install Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Install bazelisk
npm install -g @bazel/bazelisk

# Run bazelisk once in order to install /usr/local/bin/bazel binary
bazel version

# Get the installed Bazel version from bazelisk
BAZEL_VERSION=$(bazel --version | grep "Build label:" | awk '{print $3}')

# Set USE_BAZEL_FALLBACK_VERSION so that users without .bazelversion
# get the preinstalled version instead of downloading latest
set_etc_environment_variable "USE_BAZEL_FALLBACK_VERSION" "silent:${BAZEL_VERSION}"

invoke_tests "Tools" "Bazel"
