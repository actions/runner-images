#!/bin/bash -e
# https://github.com/hashicorp/packer/issues/11656
echo PubkeyAcceptedKeyTypes=+ssh-rsa >> /etc/ssh/sshd_config
systemctl reload sshd.service