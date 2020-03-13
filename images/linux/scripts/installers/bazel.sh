#!/bin/bash
################################################################################
##  File:  bazel.sh
##  Desc:  Installs Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install bazel
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
apt-get update -y
apt-get install -y bazel

# Install bazelisk
npm install -g @bazel/bazelisk

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v bazel; then
    echo "Bazel was not installed"
    exit 1
fi

if ! command -v bazelisk; then
    echo "Bazelisk was not installed"
    exit 1
fi

# Document what was added to the image
bazelisk_version="$(bazelisk version 2>null | grep "Bazelisk version:" | cut -d "v" -f 3)"

echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Bazel ($(bazel --version))"
DocumentInstalledItem "Bazelisk ($bazelisk_version)"
