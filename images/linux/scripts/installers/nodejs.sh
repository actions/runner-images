#!/bin/bash -e
################################################################################
##  File:  nodejs.sh
##  Desc:  Installs Node.js LTS and related tooling (Gulp, Grunt)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# Install default Node.js
defaultVersion=$(get_toolset_value '.node.default')
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o ~/n
bash ~/n $defaultVersion

# Install node modules
node_modules=$(get_toolset_value '.node_modules[].name')

# remove commenting out of this line as nmp migrated to v7
# npm install -g $node_modules

# TODO: workaround for Netlify CLI with npm6. Remove 19-28 and uncomment 17 if migration to npm7 compelted
for module in $node_modules; do
    echo "Installing node module $module"
    if [ $module = "netlify-cli" ];then
      # Install the Netlify CLI using --unsafe-perm=true options to avoid permission issues
      npm install -g --unsafe-perm=true $module
    else    
      npm install -g $module
    fi
done

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

# fix global modules installation as regular user
# related issue https://github.com/actions/virtual-environments/issues/3727
sudo chmod -R 777 /usr/local/lib/node_modules 
sudo chmod -R 777 /usr/local/bin

rm -rf ~/n

invoke_tests "Node" "Node.js"
