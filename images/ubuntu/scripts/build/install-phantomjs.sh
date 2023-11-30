#!/bin/bash -e
################################################################################
##  File:  install-phantomjs.sh
##  Desc:  Install PhantomJS
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install required dependencies
apt-get install -y chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev

# Define the version and hash of PhantomJS to be installed
dir_name=phantomjs-2.1.1-linux-x86_64
archive_hash="86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f"

# Download the archive and verify its integrity using checksum comparison
download_url="https://bitbucket.org/ariya/phantomjs/downloads/$dir_name.tar.bz2"
archive_path=$(download_with_retry "$download_url")
use_checksum_comparison "$archive_path" "$archive_hash"

# Extract the archive and create a symbolic link to the executable
tar xjf "$archive_path" -C /usr/local/share
ln -sf /usr/local/share/$dir_name/bin/phantomjs /usr/local/bin

invoke_tests "Tools" "Phantomjs"
