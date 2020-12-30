#!/bin/bash -e
################################################################################
##  File:  powershellcore.sh
##  Desc:  Installs powershellcore
################################################################################

# Install Powershell
apt-get install -y powershell

invoke_tests "Tools" "PowerShell Core"