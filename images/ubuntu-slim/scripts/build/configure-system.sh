#!/bin/bash -e
################################################################################
##  File: configure-system.sh
##  Desc: Post deployment system configuration actions
################################################################################

source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/os.sh

echo "chmod -R 777 /opt"
chmod -R 777 /opt
echo "chmod -R 777 /usr/share"
chmod -R 777 /usr/share

# Remove quotes around PATH
ENVPATH=$(grep 'PATH=' /etc/environment | head -n 1 | sed -z 's/^PATH=*//')
ENVPATH=${ENVPATH#"\""}
ENVPATH=${ENVPATH%"\""}
replace_etc_environment_variable "PATH" "${ENVPATH}"
echo "Updated /etc/environment: $(cat /etc/environment)"
