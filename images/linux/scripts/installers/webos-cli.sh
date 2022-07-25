#!/bin/bash -e

TIZEN_TGZ_PATH=$FILES_PATH/webOS_TV_CLI_linux_1.12.2-j22.tgz

mkdir -p /usr/share/webOS_TV_SDK
tar -xf "${TIZEN_TGZ_PATH}" -C /usr/share/webOS_TV_SDK/

DATA='
# Setting the LG_WEBOS_TV_SDK_HOME variable to the parent directory of CLI
export LG_WEBOS_TV_SDK_HOME="/usr/share/webOS_TV_SDK"

if [ -d "$LG_WEBOS_TV_SDK_HOME/CLI/bin" ]; then
  # Setting the WEBOS_CLI_TV variable to the bin directory of CLI
  export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/CLI/bin"
  # Adding the bin directory of CLI to the PATH variable
  export PATH="$PATH:$WEBOS_CLI_TV"
fi'

echo "$DATA" >> /home/gh-runner/.bashrc
echo "$DATA" >> /home/gh-runner/.profile
