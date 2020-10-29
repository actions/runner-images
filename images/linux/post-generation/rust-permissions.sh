#!/bin/bash

# Fix permissions for the Rust folder
# https://github.com/actions/virtual-environments/issues/572

rust_folder="/usr/share/rust"
rust_user=$(cut -d: -f1 /etc/passwd | tail -1)

if [ -d "$rust_folder" ]; then
    rust_folder_owner=$(ls -ld $rust_folder | awk '{print $3}')
    if [ "$rust_user" != "$rust_folder_owner" ]; then
        chown "$rust_user":docker -R $rust_folder
    fi
fi
