#!/bin/bash -e

source $HELPER_SCRIPTS/install.sh

# Install GraalVM
GRAALVM_ROOT=/usr/local/graalvm
export JAVA_HOME_GRAALVM_11=$GRAALVM_ROOT/graalvm-ce-java11*
export GRAALVM_11_BIN=$GRAALVM_ROOT/graalvm-ce-java11*/bin

url=$(curl -s https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | jq -r '.assets[].browser_download_url | select(contains("graalvm-ce-java11-linux-amd64"))')
download_with_retries "$url" "/tmp" "graalvm-archive.tar.gz"
mkdir $GRAALVM_ROOT
tar -xzf "/tmp/graalvm-archive.tar.gz" -C $GRAALVM_ROOT

# Set two variables as described here: https://www.graalvm.org/docs/getting-started/linux/
setEtcEnvironmentVariable "GRAALVM_11_BIN" $GRAALVM_11_BIN
setEtcEnvironmentVariable "JAVA_HOME_GRAALVM_11" $JAVA_HOME_GRAALVM_11

# Install Native Image
$GRAALVM_11_BIN/gu install native-image
