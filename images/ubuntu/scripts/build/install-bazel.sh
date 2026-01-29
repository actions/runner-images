#!/bin/bash -e
################################################################################
##  File:  install-bazel.sh
##  Desc:  Install Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install bazelisk
npm install -g @bazel/bazelisk

# run bazelisk once in order to install /usr/local/bin/bazel binary
sudo -u $SUDO_USER bazel version

# Get the installed Bazel version from bazelisk
BAZEL_VERSION=$(sudo -u $SUDO_USER bazel --version | grep "Build label:" | awk '{print $3}')

# Set USE_BAZEL_FALLBACK_VERSION so that users without .bazelversion
# get the preinstalled version instead of downloading latest
echo "USE_BAZEL_FALLBACK_VERSION=silent:${BAZEL_VERSION}" >> /etc/environment

invoke_tests "Tools" "Bazel"
