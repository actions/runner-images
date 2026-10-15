#!/bin/bash -e
################################################################################
##  File:  configure-packer-user.sh
##  Desc:  Create the unprivileged user that provisioners run as. Packer
##         connects to a container as root, unlike to a VM.
################################################################################

# cloud-init creates the default user and rewrites the hosts file on first boot
if command -v cloud-init > /dev/null; then
    cloud-init status --wait || [ $? -eq 2 ]
fi

if id ubuntu &> /dev/null; then
    userdel --remove ubuntu
fi

useradd --create-home --shell /bin/bash --uid 1000 --groups sudo packer
echo "packer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/packer
chmod 0440 /etc/sudoers.d/packer
