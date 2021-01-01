#!/bin/bash -e
################################################################################
##  File:  bazel.sh
##  Desc:  Installs Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Install bazel
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
apt-get update -y
apt-get install -y bazel

# Install bazelisk
npm install -g @bazel/bazelisk

invoke_tests "Tools" "Bazel"