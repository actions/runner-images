#!/bin/bash -e
################################################################################
##  File:  install-bazel.sh
##  Desc:  Install Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install bazelisk
npm install -g @bazel/bazelisk

# run bazelisk once in order to instal /usr/local/bin/bazel binary
sudo -u $SUDO_USER bazel version

invoke_tests "Tools" "Bazel"
