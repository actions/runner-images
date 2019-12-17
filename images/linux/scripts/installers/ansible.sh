#!/bin/bash
################################################################################
##  File:  ansible.sh
##  Desc:  Installs Ansible
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Install Ansible PPA and latest Ansible
add-apt-repository ppa:ansible/ansible
apt-get update
apt-get install -y --no-install-recommends ansible

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v ansible; then
    echo "Ansible was not installed or found on PATH"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Ansible ($(ansible --version |& head -n 1))"
