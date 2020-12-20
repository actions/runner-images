#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

echo Installing PHP
brew install php

echo Installing composer
brew install composer

invoke_tests "PHP"