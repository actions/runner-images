#!/bin/bash -e
################################################################################
##  File:  ansible.sh
##  Desc:  Installs Ansible
################################################################################

# Install latest Ansible
add-apt-repository ppa:ansible/ansible
apt-get update
apt-get install -y --no-install-recommends ansible

invoke_tests "Tools" "Ansible"
