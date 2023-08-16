#!/bin/bash -e -o pipefail

#
# https://github.com/actions/runner-images/issues/7987 for reference
#

source ~/utils/utils.sh

echo Allow "runner" to sudo to any user...
echo "runner ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/runner

invoke_tests "Sudoers"
