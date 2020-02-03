#!/bin/bash
################################################################################
##  File:  basic.sh
##  Desc:  Installs basic command line utilities and dev packages
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

set -e

# Install basic command-line utilities
apt-fast install -y --no-install-recommends \
    curl \
    dnsutils \
    file \
    ftp \
    iproute2 \
    iputils-ping \
    jq \
    libcurl3 \
    libicu55 \
    libunwind8 \
    locales \
    netcat \
    openssh-client \
    parallel \
    rsync \
    shellcheck \
    sudo \
    telnet \
    time \
    unzip \
    upx \
    wget \
    zip \
    tzdata

# Electron / VSCode / GitHub Desktop prereqs
apt-fast install -y --no-install-recommends \
    libxkbfile-dev \
    pkg-config \
    libsecret-1-dev \
    libxss1 \
    libgconf-2-4 \
    dbus \
    xvfb \
    libgtk-3-0 \
    fakeroot \
    dpkg \
    rpm \
    xz-utils \
    xorriso \
    zsync

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in curl file ftp jq netcat ssh parallel rsync shellcheck sudo telnet time unzip upx wget zip; do
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
DocumentInstalledItemIndent "libcurl3"
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
DocumentInstalledItemIndent "unzip"
DocumentInstalledItemIndent "upx"
DocumentInstalledItemIndent "wget"
DocumentInstalledItemIndent "zip"
DocumentInstalledItemIndent "tzdata"
