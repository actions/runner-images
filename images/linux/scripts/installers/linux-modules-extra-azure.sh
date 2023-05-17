#!/bin/bash -e
################################################################################
##  File:  linux-modules-extra-azure.sh
##  Desc:  Installs linux-modules-extra-azure
################################################################################

kernelver=$(uname -r | sed 's/-azure//' | tr '-' '.')

apt update -y && apt install -y linux-modules-extra-azure=$kernelver*