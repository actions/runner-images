#!/bin/bash

# Fix permissions for Homebrew
# https://github.com/actions/virtual-environments/issues/1568

brew_folder="/home/linuxbrew/"

if [ "$GITHUB_ACTIONS" = "true" ]; then
    homebrew_user="runner"
else
    homebrew_user="vsts"
fi

if [ -d "$brew_folder" ]; then
    brew_folder_owner=$(ls -ld $brew_folder | awk '{print $3}')
    if [ "$homebrew_user" != "$brew_folder_owner" ]; then
        chown "$homebrew_user":docker -R $brew_folder
    fi
fi
