#!/bin/bash -e

source $HELPER_SCRIPTS/install.sh

#Install GraalVM
tmp_graalvm=/tmp/graalvm
export JAVA_HOME_GRAALVM_11=/usr/local/graalvm/graalvm-ce-java11*
export GRAALVM_11_BIN=/usr/local/graalvm/graalvm-ce-java11*/bin

mkdir -p $tmp_graalvm
url=$(curl -s https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | jq -r '.assets[].browser_download_url | select(contains("graalvm-ce-java11-linux-amd64"))')
download_with_retries "$url" "$tmp_graalvm" "graalvm-archive.tar.gz"
mkdir /usr/local/graalvm
tar -xzf "$tmp_graalvm/graalvm-archive.tar.gz" -C /usr/local/graalvm
rm $tmp_graalvm

setEtcEnvironmentVariable "GRAALVM_11_BIN" $GRAALVM_11_BIN
setEtcEnvironmentVariable "JAVA_HOME_GRAALVM_11" $JAVA_HOME_GRAALVM_11

#Install Native Image
$GRAALVM_11_BIN/gu install native-image

# Run tests to determine that the software installed as expected
if ! command -v $GRAALVM_11_BIN/java --version; then
    echo "GraalVM was not installed"
    exit 1
fi

if ! command -v $GRAALVM_11_BIN/native-image; then
    echo "Native Image was not installed"
    exit 1
fi