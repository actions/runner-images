#!/bin/bash -e
################################################################################
##  File:  rndgenerator.sh
##  Desc:  Install random number generator
################################################################################


# Install haveged
apt-get -y install haveged

invoke-tests.sh "Tools" "Haveged"