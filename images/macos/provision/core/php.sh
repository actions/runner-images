#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing PHP
brew_smart_install "php"

echo Installing composer
brew_smart_install "composer"

invoke_tests "PHP"
