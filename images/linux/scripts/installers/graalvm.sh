#!/bin/bash -e

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Install GraalVM
GRAALVM_ROOT=/usr/local/graalvm
export GRAALVM_11_ROOT=$GRAALVM_ROOT/graalvm-ce-java11*

url=$(curl -s https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | jq -r '.assets[].browser_download_url | select(contains("graalvm-ce-java11-linux-amd64"))')
download_with_retries "$url" "/tmp" "graalvm-archive.tar.gz"
mkdir $GRAALVM_ROOT
tar -xzf "/tmp/graalvm-archive.tar.gz" -C $GRAALVM_ROOT

# Set environment variable for GraalVM root
setEtcEnvironmentVariable "GRAALVM_11_ROOT" $GRAALVM_11_ROOT

# Install Native Image
$GRAALVM_11_ROOT/bin/gu install native-image

invoke_tests "Tools" "GraalVM"