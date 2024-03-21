#!/bin/bash -e
################################################################################
##  File: configure-system.sh
##  Desc: Post deployment system configuration actions
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPT_FOLDER/etc-environment.sh

mv -f /imagegeneration/post-generation /opt

echo "chmod -R 777 /opt"
chmod -R 777 /opt
echo "chmod -R 777 /usr/share"
chmod -R 777 /usr/share

chmod 755 $IMAGE_FOLDER

# Remove quotes around PATH
ENVPATH=$(grep 'PATH=' /etc/environment | head -n 1 | sed -z 's/^PATH=*//')
ENVPATH=${ENVPATH#"\""}
ENVPATH=${ENVPATH%"\""}
replace_etc_environment_variable "PATH" "${ENVPATH}"
echo "Updated /etc/environment: $(cat /etc/environment)"

# Clean yarn and npm cache
if yarn --version > /dev/null; then
    yarn cache clean
fi

if npm --version; then
    npm cache clean --force
fi
