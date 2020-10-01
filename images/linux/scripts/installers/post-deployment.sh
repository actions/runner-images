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

# Remove quotes if found around PATH
if [[ $PATH == \"*\" ]]
then
    PATH=${PATH#"\""}
    PATH=${PATH%"\""}
    echo "PATH=$PATH" | sudo tee -a /etc/environment
    echo "Updated path to remove quotes: $PATH"
else
    echo "No path update needed: $PATH"
fi
