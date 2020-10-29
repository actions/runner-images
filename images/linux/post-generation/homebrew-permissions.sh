#!/bin/bash

# Fix permissions for Homebrew
# https://github.com/actions/virtual-environments/issues/1568

brew_folder="/home/linuxbrew/"
homebrew_user=$(cut -d: -f1 /etc/passwd | tail -1)

if [ -d "$brew_folder" ]; then
    brew_folder_owner=$(ls -ld $brew_folder | awk '{print $3}')
    if [ "$homebrew_user" != "$brew_folder_owner" ]; then
        chown "$homebrew_user":docker -R $brew_folder
    fi
fi
