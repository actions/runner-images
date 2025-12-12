#!/bin/bash -e
################################################################################
##  File:  install-nodejs.sh
##  Desc:  Install Node.js LTS and related tooling (Gulp, Grunt)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install default Node.js
default_version=$(get_toolset_value '.node.default')

curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/n
sudo bash ~/n $default_version

# Install node modules
node_modules=$(get_toolset_value '.node_modules[].name')
if [ -n "$node_modules" ]; then
    npm install -g $node_modules
else
    echo "No node modules to install"
fi

# fix global modules installation as regular user
# related issue https://github.com/actions/runner-images/issues/3727
sudo chmod -R 777 /usr/local/lib/node_modules 
sudo chmod -R 777 /usr/local/bin

rm -rf ~/n
