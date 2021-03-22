#!/bin/bash

# Set environmental variables related to the default user home directory

default_user=$(cut -d: -f1 /etc/passwd | tail -1)
HOME="/home/${default_user}"
envVars=$(cat /imagegeneration/env_variables)

for envVar in ${envVars[@]}
do
    eval echo $envVar | tee -a /etc/environment
done
