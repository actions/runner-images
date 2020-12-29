#!/bin/bash -e

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Swig
sudo apt-get install -y swig

invoke_tests "Tools" "Swig"
