#!/bin/bash -e
################################################################################
##  File:  bazel.sh
##  Desc:  Installs Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install bazelisk
npm install -g @bazel/bazelisk

# run bazelisk once in order to instal /usr/local/bin/bazel binary
bazelisk

invoke_tests "Tools" "Bazel"
