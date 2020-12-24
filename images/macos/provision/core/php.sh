#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing PHP
brew_install "php"

echo Installing composer
brew_install "composer"