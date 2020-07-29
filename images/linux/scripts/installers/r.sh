#!/bin/bash

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# install R
sudo apt-get install -y r-base
version=$(R --version | grep "R version" | cut -d " " -f 3)

DocumentInstalledItem "R $version"
