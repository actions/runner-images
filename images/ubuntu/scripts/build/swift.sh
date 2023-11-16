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

# Verifing pgp signature using official swift pgp key. Referring to https://www.swift.org/install/linux/#Installation-via-Tarball
# Download swift pgp key
download_with_retries "https://swift.org/keys/all-keys.asc" "/tmp" "all-keys.asc"
# Import swift pgp key
gpg --no-default-keyring --keyring swift --import /tmp/all-keys.asc
# Download signature file
download_with_retries "$swift_tar_url.sig" "/tmp" "$swift_tar_name.sig"
# Verify signature
gpg --no-default-keyring --keyring swift --verify "/tmp/$swift_tar_name.sig" "/tmp/$swift_tar_name"
# Remove swift pgp public key with temporary keyring
rm ~/.gnupg/swift


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
