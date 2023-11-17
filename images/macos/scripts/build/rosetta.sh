#!/bin/bash -e -o pipefail

echo 'Installing Rosetta'
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
