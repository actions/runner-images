#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

# What is this for?
# This script fixes an issue appeared for some brew users where brew upgrade
# would return an error code. This is caused by the official macOS
# Python installers which install files into /usr/local/bin, and some
# go installer which installs files into /usr/local/bin....
#
# What it does?
# The script tells brew to reclaim these files
#
# License
# Distributed by MIT license.

echo "Tweaking usr/local/bin Tooling"

for package in go python@3.11; do
    if brew info "$package" | grep -q ^/; then
        brew link --overwrite "$package"
    fi
done

invoke_tests "Python"
