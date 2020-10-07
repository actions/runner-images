#!/bin/bash
################################################################################
##  File: post-deployment.sh
##  Desc: Post deployment actions
################################################################################

# set chmod -R 777 /opt
if [[ -d "/opt" ]]; then
    echo "chmod -R 777 /opt"
    chmod -R 777 /opt
fi

# remove installer and helper folders
rm -rf $HELPER_SCRIPT_FOLDER
rm -rf $INSTALLER_SCRIPT_FOLDER
chmod 755 $IMAGE_FOLDER
