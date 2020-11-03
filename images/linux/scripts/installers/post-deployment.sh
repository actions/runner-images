#!/bin/bash -e
################################################################################
##  File: post-deployment.sh
##  Desc: Post deployment actions
################################################################################

mv -f /imagegeneration/post-generation /opt

# set chmod -R 777 /opt
if [[ -d "/opt" ]]; then
    echo "chmod -R 777 /opt"
    chmod -R 777 /opt
fi

# remove installer and helper folders
rm -rf $HELPER_SCRIPT_FOLDER
rm -rf $INSTALLER_SCRIPT_FOLDER
chmod 755 $IMAGE_FOLDER

# Remove quotes from PATH
PATH=${PATH#"\""}
PATH=${PATH%"\""}
echo "PATH=$PATH" | sudo tee -a /etc/environment
echo "Updated PATH: $PATH

# Clean yarn and npm cache
yarn cache clean
npm cache clean --force