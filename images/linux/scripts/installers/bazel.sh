#!/bin/bash -e
################################################################################
##  File:  bazel.sh
##  Desc:  Installs Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

source $HELPER_SCRIPTS/install.sh

# Install bazel
bazelVersion=$(curl -s -L "https://api.github.com/repos/bazelbuild/bazel/releases" | jq -r '.[] | select(.prerelease==false).name' | sort --unique --version-sort | grep -ve "-.*" | tail -1)
download_with_retries "https://github.com/bazelbuild/bazel/releases/download/${bazelVersion}/bazel-${bazelVersion}-installer-linux-x86_64.sh" "/tmp" "bazel-installer.sh"
chmod +x /tmp/bazel-installer.sh
sudo /tmp/bazel-installer.sh

invoke_tests "Tools" "Bazel"
