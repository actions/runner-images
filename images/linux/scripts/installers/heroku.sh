#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install Heroku CLI
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

invoke_tests "Tools" "Heroku"