#!/bin/bash -e
################################################################################
##  File:  nodejs.sh
##  Desc:  Installs Node.js LTS and related tooling (Gulp, Grunt)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install default Node.js
defaultVersion=$(get_toolset_value '.node.default')
curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/n
bash ~/n $defaultVersion

# Install node modules
node_modules=$(get_toolset_value '.node_modules[].name')
npm install -g $node_modules

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

# fix global modules installation as regular user
# related issue https://github.com/actions/runner-images/issues/3727
sudo chmod -R 777 /usr/local/lib/node_modules 
sudo chmod -R 777 /usr/local/bin

rm -rf ~/n

invoke_tests "Node" "Node.js"
