#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

set -e

common_packages="dnsutils
                 iproute2
                 iputils-ping
                 libc++-dev
                 libc++abi-dev
                 libcurl3
                 libicu55
                 libunwind8
                 locales
                 openssh-client
                 tzdata
                 zstd
                 lib32z1
                 libxkbfile-dev
                 pkg-config
                 libsecret-1-dev
                 libxss1
                 libgconf-2-4
                 dbus
                 xvfb
                 libgbm-dev
                 libgtk-3-0
                 tk
                 fakeroot
                 dpkg
                 rpm
                 xz-utils
                 xorriso
                 zsync
                 gnupg2
                 texinfo"

cmd_packages="curl
              file
              ftp
              jq
              netcat
              ssh
              parallel
              rsync
              shellcheck
              sudo
              telnet
              time
              unzip
              zip
              wget
              upx
              m4
              bison
              flex"

# Install basic command-line utilities
for package in $common_packages $cmd_packages; do
    echo "Install $package"
    apt-fast install -y --no-install-recommends $package
done

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in $cmd_packages; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Basic packages:"
for package in $common_packages $cmd_packages; do
    DocumentInstalledItemIndent $package
done
