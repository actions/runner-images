#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing PHP
phpVersionToolset=$(get_toolset_value '.php.version')
brew_smart_install "php@${phpVersionToolset}"

echo Installing composer
brew_smart_install "composer"

brew link --overwrite php@${phpVersionToolset}

invoke_tests "PHP"
