#!/bin/bash -e
################################################################################
##  File:  phantomjs.sh
##  Desc:  Installs PhantomJS
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install PhantomJS
apt-get install -y chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
PHANTOM_JS=phantomjs-2.1.1-linux-x86_64
download_with_retries https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 "/tmp"
tar xjf /tmp/$PHANTOM_JS.tar.bz2 -C /usr/local/share
ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

invoke_tests "Tools" "Phantomjs"
