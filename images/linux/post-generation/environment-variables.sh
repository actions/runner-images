#!/bin/bash

# Set environmental variables related to the default user home directory

default_user=$(cut -d: -f1 /etc/passwd | tail -1)
home_directory="/home/${default_user}"

echo "export XDG_CONFIG_HOME=${home_directory}/.config" | tee -a /etc/environment
echo "export NVM_DIR=${home_directory}/.nvm" | tee -a /etc/environment
