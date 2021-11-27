#!/bin/bash -e
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install
image_label="$(lsb_release -rs)"
swift_version=$(curl -s "https://api.github.com/repos/apple/swift/releases/latest" | jq -r '.tag_name | match("[0-9.]+").string')

swift_tar_name="swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz"
swift_tar_url="https://swift.org/builds/swift-$swift_version-release/ubuntu${image_label//./}/swift-$swift_version-RELEASE/$swift_tar_name"
download_with_retries $swift_tar_url "/tmp" "$swift_tar_name"

tar xzf /tmp/$swift_tar_name
mv swift-$swift_version-RELEASE-ubuntu$image_label /usr/share/swift

SWIFT_PATH="/usr/share/swift/usr/bin"
SWIFT_BIN="$SWIFT_PATH/swift"
SWIFTC_BIN="$SWIFT_PATH/swiftc"
ln -s "$SWIFT_BIN" /usr/local/bin/swift
ln -s "$SWIFTC_BIN" /usr/local/bin/swiftc
echo "SWIFT_PATH=$SWIFT_PATH" | tee -a /etc/environment

invoke_tests "Common" "Swift"
