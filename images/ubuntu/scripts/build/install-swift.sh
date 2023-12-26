#!/bin/bash -e
################################################################################
##  File:  install-swift.sh
##  Desc:  Install Swift
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Install
image_label="ubuntu$(lsb_release -rs)"
swift_version=$(curl -fsSL "https://api.github.com/repos/apple/swift/releases/latest" | jq -r '.tag_name | match("[0-9.]+").string')
swift_release_name="swift-${swift_version}-RELEASE-${image_label}"

archive_url="https://swift.org/builds/swift-${swift_version}-release/${image_label//./}/swift-${swift_version}-RELEASE/${swift_release_name}.tar.gz"
archive_path=$(download_with_retry "$archive_url")

# Verifing pgp signature using official swift pgp key. Referring to https://www.swift.org/install/linux/#Installation-via-Tarball
# Download and import swift pgp key
pgp_key_path=$(download_with_retry "https://swift.org/keys/all-keys.asc")
gpg --no-default-keyring --keyring swift --import "$pgp_key_path"

# Download and verify signature
signature_path=$(download_with_retry "${archive_url}.sig")
gpg --no-default-keyring --keyring swift --verify "$signature_path" "$archive_path"

# Remove swift pgp public key with temporary keyring
rm ~/.gnupg/swift

# Extract and install swift
tar xzf "$archive_path" -C /tmp

SWIFT_INSTALL_ROOT="/usr/share/swift"
SWIFT_BIN_ROOT="$SWIFT_INSTALL_ROOT/usr/bin"
SWIFT_LIB_ROOT="$SWIFT_INSTALL_ROOT/usr/lib"

mv "/tmp/${swift_release_name}" $SWIFT_INSTALL_ROOT
mkdir -p /usr/local/lib

ln -s "$SWIFT_BIN_ROOT/swift" /usr/local/bin/swift
ln -s "$SWIFT_BIN_ROOT/swiftc" /usr/local/bin/swiftc
ln -s "$SWIFT_LIB_ROOT/libsourcekitdInProc.so" /usr/local/lib/libsourcekitdInProc.so

set_etc_environment_variable "SWIFT_PATH" "${SWIFT_BIN_ROOT}"

invoke_tests "Common" "Swift"
