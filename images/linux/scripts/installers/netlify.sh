#!/bin/bash -e
################################################################################
##  File:  netlify.sh
##  Desc:  Installs the Netlify CLI
################################################################################

# Install the Netlify CLI
npm i -g netlify-cli

invoke_tests "Tools" "Netlify"