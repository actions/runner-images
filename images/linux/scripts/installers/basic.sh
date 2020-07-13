#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

set -e

common_packages="dnsutils
                 iproute2
                 iputils-ping
                 libunwind8
                 locales
                 openssh-client
                 tzdata
                 upx
                 zstd
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
                 lib32z1
                 texinfo
                 libsqlite3-dev"

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
              m4
              bison
              flex
              patchelf
              bzip2
              sqlite3"

if isUbuntu20 ; then
    echo "Install python2"
    apt-get install -y --no-install-recommends python-is-python2
fi

echo "Install libcurl"
if isUbuntu16 || isUbuntu18; then
   libcurelVer="libcurl3"
fi

if isUbuntu20 ; then
    libcurelVer="libcurl4"
fi

apt-get install -y --no-install-recommends $libcurelVer

# install additional packages only for Ubuntu16.04
if isUbuntu16; then
    common_packages="$common_packages
            libc++-dev
            libc++abi-dev
            libicu55"
fi

for package in $common_packages $cmd_packages; do
    echo "Install $package"
    apt-get install -y --no-install-recommends $package
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

DocumentInstalledItemIndent "$libcurelVer"
