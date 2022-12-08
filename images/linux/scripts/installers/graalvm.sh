#!/bin/bash -e
################################################################################
##  File:  graalvm.sh
##  Desc:  Installs GraalVM
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Install GraalVM
GRAALVM_ROOT=/usr/local/graalvm
export GRAALVM_11_ROOT=$GRAALVM_ROOT/graalvm-ce-java11*

downloadUrl=$(get_github_package_download_url "graalvm/graalvm-ce-builds" "contains(\"graalvm-ce-java11-linux-amd64\") and endswith(\"tar.gz\")")
download_with_retries "$downloadUrl" "/tmp" "graalvm-archive.tar.gz"
mkdir $GRAALVM_ROOT
tar -xzf "/tmp/graalvm-archive.tar.gz" -C $GRAALVM_ROOT

# Set environment variable for GraalVM root
setEtcEnvironmentVariable "GRAALVM_11_ROOT" $GRAALVM_11_ROOT

# Install Native Image
$GRAALVM_11_ROOT/bin/gu install native-image

invoke_tests "Tools" "GraalVM"
