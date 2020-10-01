#!/bin/bash
################################################################################
##  File:  sphinx.sh
##  Desc:  Installs Sphinx
################################################################################

set -e
set -o pipefail

# Install Sphinx
apt-get install -y sphinxsearch
