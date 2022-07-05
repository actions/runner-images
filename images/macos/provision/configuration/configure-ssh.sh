#!/bin/bash -e -o pipefail

[[ ! -d ~/.ssh ]] && mkdir ~/.ssh 2>/dev/null
chmod 777 ~/.ssh

ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> ~/.ssh/known_hosts
