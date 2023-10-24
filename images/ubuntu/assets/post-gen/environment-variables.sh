#!/bin/bash

# Replace $HOME with the default user's home directory for environmental variables related to the default user home directory

homeDir=$(cut -d: -f6 /etc/passwd | tail -1)
sed -i "s|\$HOME|$homeDir|g" /etc/environment