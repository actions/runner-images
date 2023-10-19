#!/bin/bash -e
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install
image_label="$(lsb_release -rs)"
swift_version=$(curl -fsSL "https://api.github.com/repos/apple/swift/releases/latest" | jq -r '.tag_name | match("[0-9.]+").string')

swift_tar_name="swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz"
swift_tar_url="https://swift.org/builds/swift-$swift_version-release/ubuntu${image_label//./}/swift-$swift_version-RELEASE/$swift_tar_name"
download_with_retries $swift_tar_url "/tmp" "$swift_tar_name"

tar xzf /tmp/$swift_tar_name

SWIFT_INSTALL_ROOT="/usr/share/swift"
SWIFT_BIN_ROOT="$SWIFT_INSTALL_ROOT/usr/bin"
SWIFT_LIB_ROOT="$SWIFT_INSTALL_ROOT/usr/lib"

mv swift-$swift_version-RELEASE-ubuntu$image_label $SWIFT_INSTALL_ROOT
mkdir -p /usr/local/lib

ln -s "$SWIFT_BIN_ROOT/swift" /usr/local/bin/swift
ln -s "$SWIFT_BIN_ROOT/swiftc" /usr/local/bin/swiftc
ln -s "$SWIFT_LIB_ROOT/libsourcekitdInProc.so" /usr/local/lib/libsourcekitdInProc.so

echo "SWIFT_PATH=$SWIFT_BIN_ROOT" | tee -a /etc/environment

invoke_tests "Common" "Swift"
