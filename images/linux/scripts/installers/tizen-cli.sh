#!/bin/bash -e

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

TIZEN_CLI_URL="https://download.tizen.org/sdk/Installer/tizen-studio_4.6/web-cli_Tizen_Studio_4.6_ubuntu-64.bin"
download_with_retries ${TIZEN_CLI_URL} "/tmp" "tizen-studio.bin"

chmod +x /tmp/tizen-studio.bin
# install tizen
su -c '/tmp/tizen-studio.bin --accept-license "${HOME}/tizen-studio"' gh-runner
# Add bin to path
su -c 'echo "export PATH=$PATH:/home/gh-runner/tizen-studio/tools/:/home/gh-runner/tizen-studio/tools/ide/bin/" >> ~/.bashrc' gh-runner
su -c 'echo "export PATH=$PATH:/home/gh-runner/tizen-studio/tools/:/home/gh-runner/tizen-studio/tools/ide/bin/" >> ~/.profile' gh-runner

# cleanup
rm "/tmp/tizen-studio.bin"
