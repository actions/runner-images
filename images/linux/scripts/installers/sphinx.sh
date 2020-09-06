#!/bin/bash
################################################################################
##  File:  sphinx.sh
##  Desc:  Installs Sphinx
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/install.sh

# Install Sphinx
wait_for_apt_lock "apt-get install -y sphinxsearch"

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Sphinx Open Source Search Server"
