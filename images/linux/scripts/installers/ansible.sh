#!/bin/bash -e
################################################################################
##  File:  ansible.sh
##  Desc:  Installs Ansible
################################################################################

# this script is used only on Ubuntu 16.04
# for Ubuntu 18.04 and 20.04 we use pipx ansible-base package
# Install latest Ansible
add-apt-repository ppa:ansible/ansible
apt-get update
apt-get install -y --no-install-recommends ansible

invoke_tests "Tools" "Ansible"
