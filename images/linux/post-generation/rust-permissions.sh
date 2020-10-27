#!/bin/bash

# Fix permissions for the Rust folder
# https://github.com/actions/virtual-environments/issues/572

rust_folder="/usr/share/rust"

if [ "$GITHUB_ACTIONS" = "true" ]; then
    rust_user="runner"
else
    rust_user="vsts"
fi

if [ -d "$rust_folder" ]; then
    rust_folder_owner=$(ls -ld $rust_folder | awk '{print $3}')
    if [ "$rust_user" != "$rust_folder_owner" ]; then
        chown "$rust_user":docker -R $rust_folder
    fi
fi
