#!/bin/bash

# Add well-known SSH host keys to known_hosts
ssh-keyscan -t rsa github.com >> /etc/ssh/ssh_known_hosts
ssh-keyscan -t rsa ssh.dev.azure.com >> /etc/ssh/ssh_known_hosts
