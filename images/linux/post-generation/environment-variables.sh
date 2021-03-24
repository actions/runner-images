#!/bin/bash

# Replace $HOME with the default user's home directory for environmental variables related to the default user home directory

default_user=$(cut -d: -f1 /etc/passwd | tail -1)
HOME="/home/${default_user}"

sed -i "s|\$HOME|$homeDir|g" /etc/environment