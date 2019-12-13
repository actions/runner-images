#!/bin/bash
################################################################################
##  File:  phantomjs.sh
##  Desc:  Installs PhantomJS
################################################################################

set -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install PhantomJS
apt-get install -y chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
PHANTOM_JS=phantomjs-2.1.1-linux-x86_64
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
tar xvjf $PHANTOM_JS.tar.bz2
mv $PHANTOM_JS /usr/local/share
ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v phantomjs; then
    echo "phantomjs was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "PhantomJS ($(phantomjs --version))"
