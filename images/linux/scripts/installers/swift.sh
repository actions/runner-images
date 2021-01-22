#!/bin/bash -e
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################


# Install
image_label="$(lsb_release -rs)"
swift_version=$(curl -s -L -N https://swift.org/download|awk -F"[ <]" '/id="swift-/ {print $4; exit}')

wget -P /tmp https://swift.org/builds/swift-$swift_version-release/ubuntu${image_label//./}/swift-$swift_version-RELEASE/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz

tar xzf /tmp/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz
mv swift-$swift_version-RELEASE-ubuntu$image_label /usr/share/swift

SWIFT_PATH="/usr/share/swift/usr/bin"
SWIFT_BIN="$SWIFT_PATH/swift"
SWIFTC_BIN="$SWIFT_PATH/swiftc"
ln -s "$SWIFT_BIN" /usr/local/bin/swift
ln -s "$SWIFTC_BIN" /usr/local/bin/swiftc
echo "SWIFT_PATH=$SWIFT_PATH" | tee -a /etc/environment

invoke_tests "Common" "Swift"