#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

# Install Heroku CLI
curl -fsSL https://cli-assets.heroku.com/install.sh | sh

invoke_tests "Tools" "Heroku"