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

# Verifying PGP signature using official Swift PGP key. Referring to https://www.swift.org/install/linux/#Installation-via-Tarball
# Download and import Swift PGP keys
gpg --keyserver hkp://keyserver.ubuntu.com \
      --recv-keys \
      '7463 A81A 4B2E EA1B 551F  FBCF D441 C977 412B 37AD' \
      '1BE1 E29A 084C B305 F397  D62A 9F59 7F4D 21A5 6D5F' \
      'A3BA FD35 56A5 9079 C068  94BD 63BC 1CFE 91D3 06C6' \
      '5E4D F843 FB06 5D7F 7E24  FBA2 EF54 30F0 71E1 B235' \
      '8513 444E 2DA3 6B7C 1659  AF4D 7638 F1FB 2B2B 08C4' \
      'A62A E125 BBBF BB96 A6E0  42EC 925C C1CC ED3D 1561' \
      '8A74 9566 2C3C D4AE 18D9  5637 FAF6 989E 1BC1 6FEA' \
      'E813 C892 820A 6FA1 3755  B268 F167 DF1A CF9C E069'
gpg --keyserver hkp://keyserver.ubuntu.com --refresh-keys Swift

# Download and verify signature
signature_path=$(download_with_retry "${archive_url}.sig")
gpg --verify "$signature_path" "$archive_path"

# Remove Swift PGP public key with temporary keyring
rm -rf ~/.gnupg

# Extract and install swift
tar xzf "$archive_path" -C /tmp

SWIFT_INSTALL_ROOT="/usr/share/swift"
swift_bin_root="$SWIFT_INSTALL_ROOT/usr/bin"
swift_lib_root="$SWIFT_INSTALL_ROOT/usr/lib"

mv "/tmp/${swift_release_name}" $SWIFT_INSTALL_ROOT
mkdir -p /usr/local/lib

ln -s "$swift_bin_root/swift" /usr/local/bin/swift
ln -s "$swift_bin_root/swiftc" /usr/local/bin/swiftc
ln -s "$swift_lib_root/libsourcekitdInProc.so" /usr/local/lib/libsourcekitdInProc.so

set_etc_environment_variable "SWIFT_PATH" "${swift_bin_root}"

invoke_tests "Common" "Swift"
