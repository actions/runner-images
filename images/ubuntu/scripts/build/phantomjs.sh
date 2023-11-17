#!/bin/bash -e
################################################################################
##  File:  phantomjs.sh
##  Desc:  Installs PhantomJS
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install PhantomJS
apt-get install -y chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
phantom_js=phantomjs-2.1.1-linux-x86_64
download_with_retries https://bitbucket.org/ariya/phantomjs/downloads/$phantom_js.tar.bz2 "/tmp"
phantom_js_hash="86dd9a4bf4aee45f1a84c9f61cf1947c1d6dce9b9e8d2a907105da7852460d2f"
use_checksum_comparison "/tmp/${phantom_js}.tar.bz2" "${phantom_js_hash}"
tar xjf /tmp/$phantom_js.tar.bz2 -C /usr/local/share
ln -sf /usr/local/share/$phantom_js/bin/phantomjs /usr/local/bin

invoke_tests "Tools" "Phantomjs"
