#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

defaultVersion=$(get_toolset_value '.node.default')

echo "Installing Node.js $defaultVersion"
brew_smart_install "node@$defaultVersion"
brew link node@$defaultVersion --force --overwrite

echo Installing yarn...
download_with_retries "https://yarnpkg.com/install.sh" "/tmp" "yarn-install.sh"
bash /tmp/yarn-install.sh

if ! is_Ventura || ! is_VenturaArm64; then
  npm_global_packages=$(get_toolset_value '.npm.global_packages[].name')
  for module in ${npm_global_packages[@]}; do
    echo "Install $module"
    npm install -g $module
done
fi

invoke_tests "Node" "Node.js"
