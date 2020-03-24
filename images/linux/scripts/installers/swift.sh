#!/bin/bash
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################

# Install # Install
image_label="$(lsb_release -rs)"
swift_version="5.1.5"

wget -P /tmp https://swift.org/builds/swift-$swift_version-release/ubuntu${image_label//./}/swift-$swift_version-RELEASE/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz
tar xzf /tmp/swift-$swift_version-RELEASE-ubuntu$image_label.tar.gz
sudo mv swift-$swift_version-RELEASE-ubuntu$image_label /usr/share/swift

SWIFT_DIR="/usr/share/swift/usr/bin/swift"
SWIFT_PATH="/usr/share/swift/usr/bin"
sudo ln -s "$SWIFT_DIR" /usr/local/bin/swift
echo "SWIFT_PATH =$SWIFT_PATH" | sudo tee -a /etc/environment

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v swift; then
    echo "Swift was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "$(swift --version)"
