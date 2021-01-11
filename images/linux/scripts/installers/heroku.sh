#!/bin/bash -e
################################################################################
##  File:  heroku.sh
##  Desc:  Installs Heroku CLI
################################################################################

# Install Heroku CLI
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

invoke_tests "Tools" "Heroku"