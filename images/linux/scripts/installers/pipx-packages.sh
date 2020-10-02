#!/bin/bash
################################################################################
##  File:  pipx-packages.sh
##  Desc:  Install tools via pipx
################################################################################


export PATH="$PATH:/opt/pipx_bin"

# Install yamlint
pipx install yamllint

if ! command -v yamllint; then
        echo "yamllint was not installed"
        exit 1
fi

echo "yamllint is successfully installed"

# Install aws sam cli
pipx install aws-sam-cli --python /opt/hostedtoolcache/Python/3.7*/x64/bin/python3.7

if ! command -v sam; then
        echo "aws sam cli was not installed"
        exit 1
fi

echo "aws sam cli is successfully installed"