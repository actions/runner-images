#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh
source $HELPER_SCRIPTS/os.sh

set -e

common_packages="dnsutils
                 file
                 ftp
                 iproute2
                 iputils-ping
                 jq
                 libunwind8
                 locales
                 netcat
                 openssh-client
                 rsync
                 shellcheck
                 sudo
                 telnet
                 time
                 tzdata
                 unzip
                 upx
                 wget
                 zip
                 zstd
                 libxkbfile-dev
                 pkg-config
                 libsecret-1-dev
                 libxss1
                 libgconf-2-4
                 dbus
                 xvfblibgbm-dev
                 libgtk-3-0
                 tk
                 fakeroot
                 dpkg
                 rpm
                 xz-utils
                 xorriso
                 zsync
                 curl
                 parallel
                 gnupg2
                 lib32z1
                 m4
                 bison
                 flex
                 texinfo"

for package in $packages; do
    echo "Install $package"
    sudo apt-get install -y --no-install-recommends $package
done

if isUbuntu20 ; then
    echo "Install python2"
    apt-get install -y --no-install-recommends python-is-python2
fi

echo "Install libcurl"
if isUbuntu18 ; then
   libcurelVer="libcurl3"
fi

if isUbuntu20 ; then
    libcurelVer="libcurl4"
fi

apt-get install -y --no-install-recommends $libcurelVer

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in curl file ftp jq netcat ssh parallel rsync shellcheck sudo telnet time unzip wget zip m4 bison flex texinfo; do
    if ! command -v $cmd; then
        echo "$cmd was not installed"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Basic CLI:"
DocumentInstalledItemIndent "curl"
DocumentInstalledItemIndent "dnsutils"
DocumentInstalledItemIndent "file"
DocumentInstalledItemIndent "ftp"
DocumentInstalledItemIndent "iproute2"
DocumentInstalledItemIndent "iputils-ping"
DocumentInstalledItemIndent "jq"
DocumentInstalledItemIndent "$libcurelVer"
DocumentInstalledItemIndent "libgbm-dev"
DocumentInstalledItemIndent "libicu55"
DocumentInstalledItemIndent "libunwind8"
DocumentInstalledItemIndent "locales"
DocumentInstalledItemIndent "netcat"
DocumentInstalledItemIndent "openssh-client"
DocumentInstalledItemIndent "parallel"
DocumentInstalledItemIndent "rsync"
DocumentInstalledItemIndent "shellcheck"
DocumentInstalledItemIndent "sudo"
DocumentInstalledItemIndent "telnet"
DocumentInstalledItemIndent "time"
DocumentInstalledItemIndent "tzdata"
DocumentInstalledItemIndent "unzip"
DocumentInstalledItemIndent "upx"
DocumentInstalledItemIndent "wget"
DocumentInstalledItemIndent "zip"
DocumentInstalledItemIndent "zstd"
DocumentInstalledItemIndent "gnupg2"
DocumentInstalledItemIndent "lib32z1"
DocumentInstalledItemIndent "m4"
DocumentInstalledItemIndent "bison"
DocumentInstalledItemIndent "flex"
DocumentInstalledItemIndent "texinfo"
